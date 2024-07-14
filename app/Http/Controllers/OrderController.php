<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\Order;
use App\Models\Product;
use App\Models\Shipping;
use App\User;
use PDF;
use Notification;
use Helper;
use Illuminate\Support\Str;
use App\Notifications\StatusNotification;
use Illuminate\Support\Facades\Http;
class OrderController extends Controller
{
    private $partnerCode = "MOMOBKUN20180529";
    private $returnUrl = "http://localhost:8000/momo-return";
    // private $returnUrl = "http://giayxin.io.vn/momo-return"; //host
    private $paymentUrl = "https://test-payment.momo.vn/v2/gateway/api/create";
    private $ipnUrl = "https://localhost:7196/payment/api/momo-ipn";
    private $accessKey = "klm05TvNBzhg7h7j";
    private $secretKey = "at67qH6mk8w5Y1nAyMoYKMWACiEi2bsa";

    private function hmacSHA256($inputData, $key)
    {
        return hash_hmac('sha256', $inputData, $key);
    }
    public static function formatDateToVietnamese($date)
    {
        $days = [
            'Mon' => 'Thứ Hai',
            'Tue' => 'Thứ Ba',
            'Wed' => 'Thứ Tư',
            'Thu' => 'Thứ Năm',
            'Fri' => 'Thứ Sáu',
            'Sat' => 'Thứ Bảy',
            'Sun' => 'Chủ Nhật',
        ];

        $months = [
            'Jan' => 'Tháng 1',
            'Feb' => 'Tháng 2',
            'Mar' => 'Tháng 3',
            'Apr' => 'Tháng 4',
            'May' => 'Tháng 5',
            'Jun' => 'Tháng 6',
            'Jul' => 'Tháng 7',
            'Aug' => 'Tháng 8',
            'Sep' => 'Tháng 9',
            'Oct' => 'Tháng 10',
            'Nov' => 'Tháng 11',
            'Dec' => 'Tháng 12',
        ];

        $day = $days[$date->format('D')];
        $month = $months[$date->format('M')];

        return "{$day} {$date->format('d')} {$month}, {$date->format('Y')} - {$date->format('g:i a')}";
    }
    private function makeSignature($accessKey, $secretKey, $amount, $extraData, $ipnUrl, $orderId, $orderInfo, $partnerCode, $redirectUrl, $requestId, $requestType)
    {
        $rawHash = "accessKey=" . $accessKey .
                   "&amount=" . $amount .
                   "&extraData=" . $extraData .
                   "&ipnUrl=" . $ipnUrl .
                   "&orderId=" . $orderId .
                   "&orderInfo=" . $orderInfo .
                   "&partnerCode=" . $partnerCode .
                   "&redirectUrl=" . $redirectUrl .
                   "&requestId=" . $requestId .
                   "&requestType=" . $requestType;

        return $this->hmacSHA256($rawHash, $secretKey);
    }

    public function createMomoPayment($requiredAmount)
    {
        $orderId = now()->timestamp;
        $requestId = uniqid();

        $signature = $this->makeSignature(
            $this->accessKey,
            $this->secretKey,
            $requiredAmount,
            '',
            $this->ipnUrl,
            $orderId,
            'ThanhToan',
            $this->partnerCode,
            $this->returnUrl,
            $requestId,
            'captureWallet'
        );

        $momoRequest = [
            'partnerCode' => $this->partnerCode,
            'partnerName' => 'Test',
            'storeId' => 'Merchant',
            'requestType' => 'captureWallet',
            'ipnUrl' => $this->ipnUrl,
            'redirectUrl' => $this->returnUrl,
            'orderId' => $orderId,
            'amount' => (string)$requiredAmount,
            'lang' => 'en',
            'autoCapture' => false,
            'orderInfo' => 'ThanhToan',
            'requestId' => $requestId,
            'extraData' => '',
            'signature' => $signature
        ];

        $response = Http::post($this->paymentUrl, $momoRequest);

        if ($response->successful()) {
            return response()->json($response->json());
        } else {
            return response()->json(['message' => 'Payment creation failed'], $response->status());
        }
    }
    public function createVnPayPayment($requiredAmount)
    {
        $vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
        $vnp_Returnurl = "http://localhost:8000/vnpay-return";
        // $vnp_Returnurl = "http://giayxin.io.vn/vnpay-return"; //host
        $vnp_TmnCode = "S6RMUB02";//Mã website tại VNPAY 
        $vnp_HashSecret = "3R1YUK6L2EVEHT36KDR7S5K25OTXI7M9"; //Chuỗi bí mật

        $vnp_TxnRef = Str::uuid()->toString();
        $vnp_OrderInfo = 'tessthanhtoan';
        $vnp_OrderType = 'billpayment';
        $vnp_Amount = $requiredAmount * 100;
        $vnp_Locale = 'vn';
        $vnp_IpAddr = $_SERVER['REMOTE_ADDR'];
        //Add Params
        $inputData = array(
            "vnp_Version" => "2.1.0", //Phiên bản cũ là 2.0.0, 2.0.1 thay đổi sang 2.1.0
            "vnp_TmnCode" => $vnp_TmnCode,
            "vnp_Amount" => $vnp_Amount,
            "vnp_Command" => "pay",
            "vnp_CreateDate" => date('YmdHis'),
            "vnp_CurrCode" => "VND",
            "vnp_IpAddr" => $vnp_IpAddr,
            "vnp_Locale" => $vnp_Locale,
            "vnp_OrderInfo" => $vnp_OrderInfo,
            "vnp_OrderType" => $vnp_OrderType,
            "vnp_ReturnUrl" => $vnp_Returnurl,
            "vnp_TxnRef" => $vnp_TxnRef
        );

        if (isset($vnp_BankCode) && $vnp_BankCode != "") {
            $inputData['vnp_BankCode'] = $vnp_BankCode;
        }
        //var_dump($inputData);
        ksort($inputData);
        $query = "";
        $i = 0;
        $hashdata = "";
        
        foreach ($inputData as $key => $value) {
            if ($i == 1) {
                $hashdata .= '&' . urlencode($key) . "=" . urlencode($value);
            } else {
                $hashdata .= urlencode($key) . "=" . urlencode($value);
                $i = 1;
            }
            $query .= urlencode($key) . "=" . urlencode($value) . '&';
        }
    
        $vnp_Url = $vnp_Url . "?" . $query;
        if (isset($vnp_HashSecret)) {
            $vnpSecureHash = hash_hmac('sha512', $hashdata, $vnp_HashSecret);
            $vnp_Url .= 'vnp_SecureHash=' . $vnpSecureHash;
        }
        return $vnp_Url;
    }

    public function checkPayment(Request $request)
    {
         // Validate the request data
    $request->validate([
        'first_name' => 'required|string|max:255',
        'last_name' => 'required|string|max:255',
        'email' => 'required|email|max:255',
        'phone' => ['required', 'regex:/^(0|\+84)?([3-9]\d{8})$/'],
        'address1' => 'required|string|max:255',
    ], [
        'first_name.required' => 'Vui lòng nhập tên của bạn.',
        'last_name.required' => 'Vui lòng nhập họ của bạn.',
        'email.required' => 'Vui lòng nhập địa chỉ email.',
        'email.email' => 'Địa chỉ email không hợp lệ.',
        'phone.required' => 'Vui lòng nhập số điện thoại.',
        'phone.regex' => 'Số điện thoại không hợp lệ.',
        'address1.required' => 'Vui lòng nhập địa chỉ.',
    ]);

        // Retrieve all data from the request
        $order_data = $request->all();
        // Initialize the payment URL variable
        $payUrl = '';
        $totalCartPrice =Helper::totalCartPrice();
        if ($request->input('payment_method') == 'momo') {
            // Assuming createMomoPayment() is a function that returns an object with properties including 'payUrl'
            $momoPayment = $this->createMomoPayment($totalCartPrice); // Adjust the amount (10000) as per your requirement
            // dd($momoPayment->getdata()->payUrl);
            $payUrl = $momoPayment->getdata()->payUrl; // Assuming 'payUrl' is a property of the returned object
            return redirect()->away($payUrl);
        }
        if ($request->input('payment_method') == 'vnpay') {
            // Assuming createMomoPayment() is a function that returns an object with properties including 'payUrl'
            $vnpayPayment = $this->createVnPayPayment($totalCartPrice); // Adjust the amount (10000) as per your requirement
            // dd($momoPayment->getdata()->payUrl);
            $payUrl = $vnpayPayment; // Assuming 'payUrl' is a property of the returned object
            return redirect()->away($payUrl);
        }
        if ($request->input('payment_method') == 'cod') {
            return $this->store($request);
        }
        // Redirect to the payment URL
        return null;
    }
    public function momoReturn(Request $request)
    {
        // Extract the resultCode from the request
        $resultCode = $request->input('resultCode');
    
        // Check if the resultCode indicates success
        if ($resultCode == '9000') {
            // Merge first name and email into the request
            $request->merge([
            'first_name' => 'Hoài Nhân',
            'last_name'=>'',
            'address1'=>'',
            'address2'=>null,
            'coupon'=>'',
            'phone'=>'',
            'post_code'=>null,
            'country'=>'VN',
            'shipping'=> 2,
            'email'=> 'hoainhan@gmail',
            'payment_method'=> 'momo'
            ]);
            // Call the store method
            $this->store($request);
            request()->session()->flash('success', 'Thanh toán thành công!');
            return redirect()->route('home');
        } else {
          
            request()->session()->flash('error', 'Thanh toán thất bại. Vui lòng thử lại.');
            return redirect()->route('home');
        }
    }
    
    public function vnpayReturn(Request $request)
    {
        // Extract the response code from the request
        $responseCode = $request->input('vnp_ResponseCode');
        
        // Check if the response code indicates success
        if ($responseCode == '00') {
            // Merge first name and email into the request
            $request->merge([
            'first_name' => 'Hoài Nhân',
            'last_name'=>'',
            'address1'=>'',
            'address2'=>null,
            'coupon'=>'',
            'phone'=>'',
            'post_code'=>null,
            'country'=>'VN',
            'shipping'=> 2,
            'email'=> 'hoainhan@gmail',
            'payment_method'=> 'vnpay'
            ]);
            // Call the store method
            $this->store($request);
    
            // Redirect to home with success message
            request()->session()->flash('success', 'Thanh toán thành công!');
            return redirect()->route('home');
        } else {
            // Payment failed, redirect to home page or show an error message
            request()->session()->flash('error', 'Thanh toán thất bại. Vui lòng thử lại.');
            return redirect()->route('home');
        }
    }
    

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $orders=Order::all();
        return view('backend.order.index')->with('orders',$orders);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }
   

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request,[
            'first_name'=>'string|required',
            'last_name'=>'string|nullable',
            'address1'=>'string|nullable',
            'address2'=>'string|nullable',
            'coupon'=>'nullable|numeric',
            'phone'=>'numeric|nullable',
            'post_code'=>'string|nullable',
            'email'=>'string|nullable'
        ]);
        // return $request->all();

        if(empty(Cart::where('user_id',auth()->user()->id)->where('order_id',null)->first())){
            request()->session()->flash('error','Cart is Empty !');
            return back();
        }

        $order=new Order();
        $order_data=$request->all();
        $order_data['order_number']='ORD-'.strtoupper(Str::random(10));
        $order_data['user_id']=$request->user()->id;
        $order_data['shipping_id']=$request->shipping;
        $shipping=Shipping::where('id',$order_data['shipping_id'])->pluck('price');
        // return session('coupon')['value'];
        $order_data['sub_total']=Helper::totalCartPrice();
        $order_data['quantity']=Helper::cartCount();
       // Check if coupon session exists
        if (session('coupon')) {
            $order_data['coupon'] = session('coupon')['value'];
        } else {
            $order_data['coupon'] = null; // Set to null if no coupon is present
        }
        if($request->shipping){
            if(session('coupon')){
                $order_data['total_amount']=Helper::totalCartPrice()+$shipping[0]-session('coupon')['value'];
            }
            else{
                $order_data['total_amount']=Helper::totalCartPrice()+$shipping[0];
            }
        }
        else{
            if(session('coupon')){
                $order_data['total_amount']=Helper::totalCartPrice()-session('coupon')['value'];
            }
            else{
                $order_data['total_amount']=Helper::totalCartPrice();
            }
        }
        // return $order_data['total_amount'];
        $order_data['status']="new";
        if(request('payment_method')=='momo'){
            $order_data['payment_method']='momo';
            $order_data['payment_status']='paid';
        } else 
        if(request('payment_method')=='vnpay'){
            $order_data['payment_method']='vnpay';
            $order_data['payment_status']='paid';
        } 
        else{
            $order_data['payment_method']='cod';
            $order_data['payment_status']='unpaid';
        }
        $order->fill($order_data);
        $status=$order->save();
        if($order)
        // dd($order->id);
        $users=User::where('role','admin')->first();
        $details=[
            'title'=>'Có đơn hàng mới',
            'actionURL'=>route('order.show',$order->id),
            'fas'=>'fa-file-alt'
        ];
        Notification::send($users, new StatusNotification($details));
        if(request('payment_method')=='paypal'){
            return redirect()->route('payment')->with(['id'=>$order->id]);
        }
        else{
            session()->forget('cart');
            session()->forget('coupon');
        }
        Cart::where('user_id', auth()->user()->id)->where('order_id', null)->update(['order_id' => $order->id]);
        // Retrieve cart items for the user
        $cartItems = Cart::where('user_id', auth()->user()->id)->where('order_id', $order->id)->get();

        // Update the stock of each product
        foreach ($cartItems as $item) {
            $product = Product::find($item->product_id);
            if ($product) {
                $product->stock -= $item->quantity;
                $product->save();
            }
        }
        // dd($users);
        request()->session()->flash('success','Bạn đã đặt hàng thành công');
        return redirect()->route('home');
    }
    public function cancelOrder($id)
    {
        $order = Order::find($id);
        $cartItems = Cart::where('user_id', auth()->user()->id)->where('order_id', $id)->get();
        // Update the stock of each product
        foreach ($cartItems as $item) {
        $product = Product::find($item->product_id);
        if ($product) {
            $product->stock += $item->quantity;
            $product->save();
            }
        }
        if ($order && ($order->status == 'new' || $order->status == 'process')) {
            $order->status = 'cancel';
            $order->save();
        return redirect()->back()->with('success', 'Order has been canceled successfully.');
        }
        return redirect()->back()->with('error', 'Unable to cancel the order.');
    }
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $order = Order::find($id);
        $cartItems = Cart::where('order_id', $id)->get();
    
        // Retrieve all products related to the cart items
        $productIds = $cartItems->pluck('product_id')->toArray();
        $products = Product::whereIn('id', $productIds)->get();
    
        return view('backend.order.show')->with([
            'order' => $order,
            'cartItems' => $cartItems,
            'products' => $products
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $order=Order::find($id);
        return view('backend.order.edit')->with('order',$order);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $order = Order::find($id);
        $this->validate($request, [
            'status' => 'required|in:new,process,delivered,cancel',
            'payment_status' => 'nullable'
        ]);
    
        $data = $request->all();
    
        if($request->status == 'delivered'){
            foreach($order->cart as $cart){
                $product = $cart->product;
                $product->stock -= $cart->quantity;
                $product->save();
            }
            $data['payment_status'] = 'paid';
        }
    
        $status = $order->fill($data)->save();
    
        if($status){
            request()->session()->flash('success', 'Cập nhật đơn hàng thành công');
        } else {
            request()->session()->flash('error', 'Có lỗi khi cập nhật đơn hàng');
        }
    
        return redirect()->route('order.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $order=Order::find($id);
        if($order){
            $status=$order->delete();
            if($status){
                request()->session()->flash('success','Xóa đơn hàng thành công');
            }
            else{
                request()->session()->flash('error','Đơn hàng không thể xóa');
            }
            return redirect()->route('order.index');
        }
        else{
            request()->session()->flash('error','Không tìm thấy đơn hàng');
            return redirect()->back();
        }
    }

    public function orderTrack(){
        return view('frontend.pages.order-track');
    }

    public function productTrackOrder(Request $request){
        // return $request->all();
        $order=Order::where('user_id',auth()->user()->id)->where('order_number',$request->order_number)->first();
        if($order){
            if($order->status=="new"){
            request()->session()->flash('success','Đơn hàng của bạn đã được đặt. Vui lòng chờ.');
            return redirect()->route('order.track');

            }
            elseif($order->status=="process"){
                request()->session()->flash('success','Đơn hàng của bạn đang được xử lý. Vui lòng chờ.');
                return redirect()->route('order.track');

            }
            elseif($order->status=="delivered"){
                request()->session()->flash('success','Đơn hàng của bạn đã được giao. Xin chân thành cảm ơn.');
                return redirect()->route('order.track');

            }
            else{
                request()->session()->flash('error','Đơn hàng của bạn đã bị hủy, vui lòng thử lại.');
                return redirect()->route('order.track');

            }
        }
        else{
            request()->session()->flash('error','Mã đơn hàng không hợp lệ, vui lòng thử lại.');
            return back();
        }
    }

    // PDF generate
    public function pdf(Request $request){
        $order=Order::getAllOrder($request->id);
        // return $order;
        $file_name=$order->order_number.'-'.$order->first_name.'.pdf';
        // return $file_name;
        $pdf=PDF::loadview('backend.order.pdf',compact('order'));
        return $pdf->download($file_name);
    }
    // Income chart
    public function incomeChart(Request $request){
        $year = \Carbon\Carbon::now()->year;
        \Carbon\Carbon::setLocale('vi'); // Set locale to Vietnamese
    
        $items = Order::with(['cart_info'])
            ->whereYear('created_at', $year)
            ->where('status', 'delivered')
            ->get()
            ->groupBy(function($d){
                return \Carbon\Carbon::parse($d->created_at)->format('m');
            });
    
        $result = [];
        foreach($items as $month => $item_collections){
            foreach($item_collections as $item){
                $amount = $item->cart_info->sum('amount');
                $m = intval($month);
                isset($result[$m]) ? $result[$m] += $amount : $result[$m] = $amount;
            }
        }
    
        $data = [];
        for($i = 1; $i <= 12; $i++){
            $monthName = \Carbon\Carbon::createFromFormat('m', $i)->translatedFormat('F'); // Translate month name
            $data[$monthName] = (!empty($result[$i])) ? number_format((float)($result[$i]), 2, '.', '') : 0.0;
        }
    
        return response()->json($data);
    }
    

    // Income chart quarterly
    public function incomeChartQuarterly(Request $request){
        $year = \Carbon\Carbon::now()->year;
        \Carbon\Carbon::setLocale('vi'); // Set locale to Vietnamese
    
        $items = Order::with(['cart_info'])
            ->whereYear('created_at', $year)
            ->where('status', 'delivered')
            ->get()
            ->groupBy(function($order) {
                return ceil(\Carbon\Carbon::parse($order->created_at)->month / 3); // Group by quarters
            });
    
        $result = [];
        foreach($items as $quarter => $orderCollections){
            foreach($orderCollections as $order){
                $amount = $order->cart_info->sum('amount');
                isset($result[$quarter]) ? $result[$quarter] += $amount : $result[$quarter] = $amount;
            }
        }
    
        $data = [];
        for($i = 1; $i <= 4; $i++){
            $quarterName = 'Quý ' . $i;
            $data[$quarterName] = (!empty($result[$i])) ? number_format((float)($result[$i]), 2, '.', '') : 0.0;
        }
    
        return response()->json($data);
    }    
}
