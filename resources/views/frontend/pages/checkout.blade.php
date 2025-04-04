@extends('frontend.layouts.mastercheckout')

@section('title', 'Shopgiay || Thanh Toán')

@section('main-content')

    <!-- Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="bread-inner">
                        <ul class="bread-list">
                            <li><a href="{{ route('home') }}">Trang Chủ<i class="ti-arrow-right"></i></a></li>
                            <li class="active"><a href="javascript:void(0)">Thanh Toán</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Breadcrumbs -->

    <!-- Start Checkout -->
    <section class="shop checkout section">
        <div class="container">
            <form class="form" id="form" method="POST" action="{{ route('cart.checkPayment') }}">
                @csrf
                <div class="row">
	                <!-- Shopping Summery -->
                    <table class="table shopping-summery">
						<thead>
							<tr class="main-hading">
								<th>Ảnh Sản Phẩm</th>
								<th>Tên Sản Phẩm</th>
                                <th>Size</th>
								<th class="text-center">Đơn Giá</th>
								<th class="text-center">Số Lượng</th>
								<th class="text-center">Tổng Tiền</th>
					
							</tr>
						</thead>
						<tbody id="cart_item_list">
							<form action="{{route('cart.update')}}" method="POST">
								@csrf
								@if(Helper::getAllProductFromCart())
									@foreach(Helper::getAllProductFromCart() as $key=>$cart)
										<tr>
											@php
											$photo=explode(',',$cart->product['photo']);
											@endphp
											<td class="image" data-title="No"><img src="{{asset($photo[0])}}" alt="{{asset($photo[0])}}"></td>
											<td class="product-des" data-title="Description">
												<p class="product-name"><a href="{{route('product-detail',$cart->product['slug'])}}" target="_blank">{{$cart->product['title']}}</a></p>
												<p class="product-des">{!!($cart['summary']) !!}</p>
											</td>
                                            <td class="size" data-title="size"><span>{{$cart->size}}</span></td>
											<td class="price" data-title="Price"><span>{{number_format($cart['price'],0)}} đ</span></td>
										
                                            <td class="qty" data-title="Qty"><span class="money">{{$cart->quantity}}</span></td>
											<td class="total-amount cart_single_price" data-title="Total"><span class="money">{{number_format($cart['amount']),0}} đ</span></td>

											
										</tr>
									@endforeach
									<track>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</track>
								@else
										<tr>
											<td class="text-center">
												Không có giỏ hàng nào có sẵn. <a href="{{route('product-grids')}}" style="color:blue;">Tiếp tục mua sắm.</a>

											</td>
										</tr>
								@endif

							</form>
						</tbody>
					</table>
					<!--/ End Shopping Summery -->
                    <div class="col-lg-8 col-12">
                        <div class="checkout-form">
                            <h2>Thực Hiện Thanh Toán</h2>
                            <p></p>
                            <!-- Form -->
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-12">
                                    <div class="form-group">
                                        <label>Họ<span>*</span></label>
                                        <input type="text" name="first_name" placeholder=""
                                            value="{{ old('first_name') }}" value="{{ old('first_name') }}">
                                        @error('first_name')
                                            <span class='text-danger'>{{ $message }}</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-12">
                                    <div class="form-group">
                                        <label>Tên <span>*</span></label>
                                        <input type="text" name="last_name" placeholder="" value="{{ old('lat_name') }}">
                                        @error('last_name')
                                            <span class='text-danger'>{{ $message }}</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-12">
                                    <div class="form-group">
                                        <label>Địa chỉ Email<span>*</span></label>
                                        <input type="email" name="email" placeholder="" value="{{ old('email') }}">
                                        @error('email')
                                            <span class='text-danger'>{{ $message }}</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-12">
                                    <div class="form-group">
                                        <label>Số điện thoại <span>*</span></label>
                                        <input type="tel" name="phone" placeholder="" required
                                            value="{{ old('phone') }}">
                                        @error('phone')
                                            <span class='text-danger'>{{ $message }}</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-6 col-12">
                                    <div class="form-group">
                                        <label>Địa chỉ<span>*</span></label>
                                        <input type="text" name="address" id="address" placeholder="" value="{{ old('address1') }}">
                                        @error('address1')
                                            <span class='text-danger'>{{ $message }}</span>
                                        @enderror
                                    </div>
                                </div>
                                <input type="text" name="address1" id="address1" value="" hidden>
                                <input type="text" name="country" id="country" value="VN" hidden>
                                <div>
<select class="form-select form-select mb-3" id="city">
<option value="" selected>Chọn tỉnh thành</option>           
</select>
          
<select class="form-select form-select mb-3" id="district">
<option value="" selected>Chọn quận huyện</option>
</select>

<select class="form-select form-select mb-3" id="ward">
<option value="" selected>Chọn phường xã</option>
</select>
 </div>    


    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
	var citis = document.getElementById("city");
    var districts = document.getElementById("district");
    var wards = document.getElementById("ward");
    var address = document.getElementById("address");
    var address1 = document.getElementById("address1");
    var address2 = "";
    var Parameter = {
  url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json", 
  method: "GET", 
  responseType: "application/json", 
};
var promise = axios(Parameter);
promise.then(function (result) {
  renderCity(result.data);
});

function renderCity(data) {
  for (const x of data) {
    citis.options[citis.options.length] = new Option(x.Name, x.Id);
  }
  citis.onchange = function () {
    district.length = 1;
    ward.length = 1;
    address2 = citis.options[citis.selectedIndex].text;
    address1.value = address.value + ', ' + address2;
    if(this.value != ""){
      const result = data.filter(n => n.Id === this.value);

      for (const k of result[0].Districts) {
        district.options[district.options.length] = new Option(k.Name, k.Id);
      }
    }
  };
  district.onchange = function () {
    ward.length = 1;
    const dataCity = data.filter((n) => n.Id === citis.value);
    address2 = district.options[district.selectedIndex].text + ', ' +   citis.options[citis.selectedIndex].text;
    address1.value = address.value + ', ' + address2;
    if (this.value != "") {
      const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;

      for (const w of dataWards) {
        wards.options[wards.options.length] = new Option(w.Name, w.Id);
      }
    }
  };
  wards.onchange = function () {
                address2 = wards.options[wards.selectedIndex].text + ', ' + district.options[district.selectedIndex].text + ', '+ citis.options[citis.selectedIndex].text  ;
                address1.value = address.value + ', ' + address2;
                console.log(address1.value)
            };
            address.onkeydown = function () {
                address2 = wards.options[wards.selectedIndex].text + ', ' + district.options[district.selectedIndex].text + ', '+ citis.options[citis.selectedIndex].text  ;
                address1.value = address.value + ', ' + address2;
                console.log(address1.value)
            };
}
	</script>
                                <!-- <div class="col-lg-6 col-md-6 col-12">
                                                        <div class="form-group">
                                                            <label>Địa chỉ 2</label>
                                                            <input type="text" name="address2" placeholder="" value="{{ old('address2') }}">
                                                            @error('address2')
        <span class='text-danger'>{{ $message }}</span>
    @enderror
                                                        </div>
                                                    </div> -->
                                <!-- <div class="col-lg-6 col-md-6 col-12">
                                                        <div class="form-group">
                                                            <label>Mã bưu chính</label>
                                                            <input type="text" name="post_code" placeholder="" value="{{ old('post_code') }}">
                                                            @error('post_code')
        <span class='text-danger'>{{ $message }}</span>
    @enderror
                                                        </div>
                                                    </div> -->

                            </div>
                            <!--/ End Form -->
                        </div>
                    </div>
                    <div class="col-lg-4 col-12">
                        <div class="order-details">
                            <!-- Order Widget -->
                            <div class="single-widget">
                                <h2>Tổng Tiền Giỏ Hàng</h2>
                                <div class="content">
                                    <ul>
                                        <li class="order_subtotal" data-price="{{ Helper::totalCartPrice() }}">Tiền Sản
                                            Phẩm<span>{{ number_format(Helper::totalCartPrice(), 0) }} đ</span></li>
                                        <li class="shipping">
                                            Phí Giao Hàng
                                            @if (count(Helper::shipping()) > 0 && Helper::cartCount() > 0)
                                                <select name="shipping" class="nice-select">
                                                    <!-- <option value="">Lựa chọn địa chỉ của bạn</option> -->
                                                    @foreach (Helper::shipping() as $shipping)
                                                        <option value="{{ $shipping->id }}" class="shippingOption"
                                                            data-price="{{ $shipping->price }}">{{ $shipping->type }}:
                                                            {{ $shipping->price }} đ</option>
                                                    @endforeach
                                                </select>
                                            @else
                                                <span>Miễn Phí</span>
                                            @endif
                                        </li>

                                        @if (session('coupon'))
                                            <li class="coupon_price" data-price="{{ session('coupon')['value'] }}">Bạn tiết
                                                kiệm được<span>{{ number_format(session('coupon')['value'], 0) }}đ</span>
                                            </li>
                                        @endif
                                        @php
                                            $total_amount = Helper::totalCartPrice();
                                            if (session('coupon')) {
                                                $total_amount = $total_amount - session('coupon')['value'];
                                            }
                                        @endphp
                                        @if (session('coupon'))
                                            <li class="last" id="order_total_price">Tổng
                                                Tiền<span>{{ number_format($total_amount, 0) }} đ</span></li>
                                        @else
                                            <li class="last" id="order_total_price">Tổng
                                                Tiền<span>{{ number_format($total_amount, 0) }} đ</span></li>
                                        @endif
                                    </ul>
                                </div>
                            </div>
                            <!--/ End Order Widget -->
                             <!--/ End Order Widget -->
                            <!-- Order Widget -->
                            <div class="single-widget">
                                <h2>Phương Thức Thanh Toán</h2>
                                <div class="content">
                                    <div class="checkbox">
                                        <form-group>
                                            <input name="payment_method" type="radio" value="cod" checked> 
                                            <label>
                                                <img src="{{ asset('payment_logo/cash_logo.jpg') }}" alt="Thanh Toán Bằng Tiền Mặt" style="width:70px; height:50px;">
                                                Thanh Toán Bằng Tiền Mặt
                                            </label><br>
                                            <input name="payment_method" type="radio" value="momo"> 
                                            <label>
                                                <img src="{{ asset('payment_logo/momo_logo.jpg') }}" alt="Momo" style="width:50px; height:40px;padding-left:7px;">
                                                Momo
                                            </label><br>
                                            <input name="payment_method" type="radio" value="vnpay"> 
                                            <label>
                                                <img src="{{ asset('payment_logo/vnpay_logo.jpg') }}" alt="VnPay" style="width:50px; height:auto;padding-left:8px;">
                                                VnPay
                                            </label>
                                        </form-group>
                                    </div>
                                </div>
                            </div>
                            <!--/ End Order Widget -->
                            <!-- Payment Method Widget -->
                            <!-- <div class="single-widget payement">
                                                    <div class="content">
                                                        <img src="{{ 'backend/img/payment-method.png' }}" alt="#">
                                                    </div>
                                                </div> -->
                            <!--/ End Payment Method Widget -->
                            <!-- Button Widget -->
                            <div class="single-widget get-button">
                                <div class="content">
                                    <div class="button">
                                        <button type="submit" class="btn" id="btn">Thanh Toán</button>
                                    </div>
                                </div>
                            </div>
                            <!--/ End Button Widget -->
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>
    <!--/ End Checkout -->

    <!-- Start Shop Services Area -->
    <section class="shop-services section home">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-12">
                    <!-- Start Single Service -->
                    <div class="single-service">
                        <i class="ti-rocket"></i>
                        <h4>Miễn Phí Giao Hàng</h4>
                        <p>Miễn phí giao hàng nội thành</p>
                    </div>
                    <!-- End Single Service -->
                </div>
                <div class="col-lg-3 col-md-6 col-12">
                    <!-- Start Single Service -->
                    <div class="single-service">
                        <i class="ti-reload"></i>
                        <h4>Miễn Phí Hoàn Trả</h4>
                        <p>Trong vòng 30 ngày</p>
                    </div>
                    <!-- End Single Service -->
                </div>
                <div class="col-lg-3 col-md-6 col-12">
                    <!-- Start Single Service -->
                    <div class="single-service">
                        <i class="ti-lock"></i>
                        <h4>Bảo Mật Thanh Toán</h4>
                        <p>100% Bảo Mật Thanh Toán</p>
                    </div>
                    <!-- End Single Service -->
                </div>
                <div class="col-lg-3 col-md-6 col-12">
                    <!-- Start Single Service -->
                    <div class="single-service">
                        <i class="ti-tag"></i>
                        <h4>Giá Tốt Nhất</h4>
                        <p>Đảm Bảo Giá Tốt Nhất</p>
                    </div>
                    <!-- End Single Service -->
                </div>
            </div>
        </div>
    </section>
    <!-- End Shop Services Area -->

    <!-- Start Shop Newsletter  -->
    <!-- <section class="shop-newsletter section" style="padding-top: 0px">
        <div class="container">
            <div class="inner-top">
                <div class="row">
                    <div class="col-lg-8 offset-lg-2 col-12">
                   
                        <div class="inner">
                            <h4>Tin Tức</h4>
                            <p> Đăng ký nhận thông báo tin tức mới nhất và được giảm giá <span>10%</span> giá trị đơn hàng
                                đầu tiên</p>
                            <form action="{{ route('subscribe') }}" method="post" class="newsletter-inner">
                                @csrf
                                <input name="email" placeholder="Nhập Email của bạn...." required=""
                                    type="email">
                                <button class="btn" type="submit">Đăng Ký</button>
                            </form>
                        </div>
                
                    </div>
                </div>
            </div>
        </div>
    </section> -->
    <!-- End Shop Newsletter -->
@endsection
@push('styles')
    <style>
        li.shipping {
            display: inline-flex;
            width: 100%;
            font-size: 14px;
        }

        li.shipping .input-group-icon {
            width: 100%;
            margin-left: 10px;
        }

        .input-group-icon .icon {
            position: absolute;
            left: 20px;
            top: 0;
            line-height: 40px;
            z-index: 3;
        }

        .form-select {
            height: 30px;
            width: 100%;
        }

        .form-select .nice-select {
            border: none;
            border-radius: 0px;
            height: 40px;
            background: #f6f6f6 !important;
            padding-left: 45px;
            padding-right: 40px;
            width: 100%;
        }

        .list li {
            margin-bottom: 0 !important;
        }

        .list li:hover {
            background: #F7941D !important;
            color: white !important;
        }

        .form-select .nice-select::after {
            top: 14px;
        }
    </style>
@endpush
@push('scripts')
    <!-- <script src="{{ asset('frontend/js/nice-select/js/jquery.nice-select.min.js') }}"></script>
    <script src="{{ asset('frontend/js/select2/js/select2.min.js') }}"></script> -->
    <script>
        // $(document).ready(function() {
        //     $("select.select2").select2();
        // });
        // $('select.nice-select').niceSelect();
    </script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.getElementById('btn').addEventListener('click', function(event) {
            event.preventDefault(); // Prevent the default form submission
            Swal.fire({
                title: 'Xác Nhận Thanh Toán',
                text: "Bạn có chắc chắn muốn thanh toán không?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Có',
                cancelButtonText: 'Hủy'
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('form').submit(); // Submit the form if confirmed
                }
            });
        });
    </script>
    <script>
        function showMe(box) {
            var checkbox = document.getElementById('shipping').style.display;
            // alert(checkbox);
            var vis = 'none';
            if (checkbox == "none") {
                vis = 'block';
            }
            if (checkbox == "block") {
                vis = "none";
            }
            document.getElementById(box).style.display = vis;
        }
    </script>
    <script>
        $(document).ready(function() {
            $('.shipping select[name=shipping]').change(function() {
                let cost = parseFloat($(this).find('option:selected').data('price')) || 0;
                let subtotal = parseFloat($('.order_subtotal').data('price'));
                let coupon = parseFloat($('.coupon_price').data('price')) || 0;
                // alert(coupon);
                $('#order_total_price span').text((subtotal + cost - coupon).toFixed(0) + 'đ');
            });

        });
    </script>
@endpush
