
	<!-- Start Footer Area -->
	<footer class="footer">
		<!-- Footer Top -->
		<div class="footer-top section" style="padding-bottom: 50px; padding-top: 50px">
			<div class="container">
				<div class="row">
					<div class="col-lg-5 col-md-6 col-12">
						<!-- Single Widget -->
						<div class="single-footer about">
							<div class="logo">
								<!-- <a href="index.html"><img src="{{asset('/storage/photos/33/LOGO_Footer_1.png')}}" alt="#"></a> -->
							</div>
							@php
								$settings=DB::table('settings')->get();
							@endphp
							<p class="text">Chúng tôi hiểu rằng một đôi giày tốt không chỉ mang lại sự thoải mái mà còn là biểu tượng của phong cách và cá tính. Vì vậy, chúng tôi cam kết cung cấp những sản phẩm giày dép chất lượng, bền đẹp và hợp thời trang. Từ những đôi giày công sở sang trọng, giày thể thao năng động đến những đôi giày dạo phố trẻ trung, chúng tôi đều có sẵn để đáp ứng mọi nhu cầu và sở thích của bạn.</p>
							<!-- <p class="call">Nếu bạn có câu hỏi? Gọi ngay cho chúng tôi.<span style="margin-top: 10px"><a href="tel:0398314279" >@foreach($settings as $data) {{$data->phone}} @endforeach</a></span></p> -->
						</div>
						<!-- End Single Widget -->
					</div>
					<div class="col-lg-2 col-md-6 col-12">
						<!-- Single Widget -->
						<div class="single-footer links">
							<h4>Thông tin</h4>
							<ul>
								<li><a href="{{route('about-us')}}">Thông Tin</a></li>
								<li><a>FaQ</a></li>
								<li><a>Điều Khoản & Điều Kiện</a></li>
								<li><a href="{{route('contact')}}">Liên Hệ</a></li>
								<li><a>Hỗ Trợ</a></li>
							</ul>
						</div>
						<!-- End Single Widget -->
					</div>
					<div class="col-lg-2 col-md-6 col-12">
						<!-- Single Widget -->
						<div class="single-footer links">
							<h4>Dịch Vụ</h4>
							<ul>
								<li><a>Phương Thức Thanh Toán</a></li>
								<li><a>Hoàn Trả Tiền</a></li>
								<li><a>Hoàn Trả</a></li>
								<li><a>Giao Hàng</a></li>
								<li><a>Chính Sách Bảo Mật</a></li>
							</ul>
						</div>
						<!-- End Single Widget -->
					</div>
					<div class="col-lg-3 col-md-12 col-12">
						<!-- Single Widget -->
						<div class="single-footer social">
							<h4>Liên Hệ</h4>
							<!-- Single Widget -->
							<div class="contact">
								<ul>
									<li><a>Địa chỉ: 65 Đ. Huỳnh Thúc Kháng, Bến Nghé, Quận 1, Hồ Chí Minh</a></li>
									<li><a>Email: caothang@caothang.edu.vn</a></li>
									<li><a>SĐT: 0969798999</a></li>
								</ul>
							</div>
							<!-- End Single Widget -->
                            <br>
						</div>
						<!-- End Single Widget -->
					</div>
				</div>
			</div>
		</div>
		<!-- End Footer Top -->
		<div class="copyright">
			<div class="container">
				<div class="inner">
					<div class="row">
						<div class="col-lg-6 col-12">
							<div class="left">
								<p>Copyright © {{date('Y')}} <a href="" target="_blank">ShoesShop</a>  -  All Rights Reserved.</p>
							</div>
						</div>
						<div class="col-lg-6 col-12">
							<!-- <div class="right">
								<img src="{{asset('backend/img/payments.png')}}" alt="#">
							</div> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- /End Footer Area -->

	<!-- Jquery -->



    <script src="{{asset('frontend/js/jquery.min.js')}}"></script>
    <script src="{{asset('frontend/js/jquery-migrate-3.0.0.js')}}"></script>
	<script src="{{asset('frontend/js/jquery-ui.min.js')}}"></script>
	<!-- Popper JS -->
	<script src="{{asset('frontend/js/popper.min.js')}}"></script>
	<!-- Bootstrap JS -->
	<script src="{{asset('frontend/js/bootstrap.min.js')}}"></script>
	<!-- Color JS -->
	<script src="{{asset('frontend/js/colors.js')}}"></script>
	<!-- Slicknav JS -->
	<script src="{{asset('frontend/js/slicknav.min.js')}}"></script>
	<!-- Owl Carousel JS -->
	<script src="{{asset('frontend/js/owl-carousel.js')}}"></script>
	<!-- Magnific Popup JS -->
	<script src="{{asset('frontend/js/magnific-popup.js')}}"></script>
	<!-- Waypoints JS -->
	<script src="{{asset('frontend/js/waypoints.min.js')}}"></script>
	<!-- Countdown JS -->
	<script src="{{asset('frontend/js/finalcountdown.min.js')}}"></script>
	<!-- Nice Select JS -->
	<script src="{{asset('frontend/js/nicesellect.js')}}"></script>
	<!-- Flex Slider JS -->
	<script src="{{asset('frontend/js/flex-slider.js')}}"></script>
	<!-- ScrollUp JS -->
	<script src="{{asset('frontend/js/scrollup.js')}}"></script>
	<!-- Onepage Nav JS -->
	<script src="{{asset('frontend/js/onepage-nav.min.js')}}"></script>
	{{-- Isotope --}}
	<script src="{{asset('frontend/js/isotope/isotope.pkgd.min.js')}}"></script>
	<!-- Easing JS -->
	<script src="{{asset('frontend/js/easing.js')}}"></script>

	<!-- Active JS -->
	<script src="{{asset('frontend/js/active.js')}}"></script>


	@stack('scripts')
	<script>
		setTimeout(function(){
		  $('.alert').slideUp();
		},5000);
		$(function() {
		// ------------------------------------------------------- //
		// Multi Level dropdowns
		// ------------------------------------------------------ //
			$("ul.dropdown-menu [data-toggle='dropdown']").on("click", function(event) {
				event.preventDefault();
				event.stopPropagation();

				$(this).siblings().toggleClass("show");


				if (!$(this).next().hasClass('show')) {
				$(this).parents('.dropdown-menu').first().find('.show').removeClass("show");
				}
				$(this).parents('li.nav-item.dropdown.show').on('hidden.bs.dropdown', function(e) {
				$('.dropdown-submenu .show').removeClass("show");
				});

			});
		});
	  </script>
