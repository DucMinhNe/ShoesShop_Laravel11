<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class PaymentController extends Controller
{
    private $partnerCode = "MOMOBKUN20180529";
    private $returnUrl = "https://localhost:7196/api/payment/momo-return";
    private $paymentUrl = "https://test-payment.momo.vn/v2/gateway/api/create";
    private $ipnUrl = "https://localhost:7196/payment/api/momo-ipn";
    private $accessKey = "klm05TvNBzhg7h7j";
    private $secretKey = "at67qH6mk8w5Y1nAyMoYKMWACiEi2bsa";

    private function hmacSHA256($inputData, $key)
    {
        return hash_hmac('sha256', $inputData, $key);
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
}
