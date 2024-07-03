@extends('backend.layouts.master')

@section('main-content')
    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="row">
            <div class="col-md-12">
                @include('backend.layouts.notification')
            </div>
        </div>
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary float-left">Danh sách sản phẩm</h6>
            <a href="{{ route('product.create') }}" class="btn btn-primary btn-sm float-right" data-toggle="tooltip"
                data-placement="bottom" title="Add User"><i class="fas fa-plus"></i> Thêm sản phẩm</a>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                @if (count($products) > 0)
                    <table class="table table-bordered" id="product-dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tiêu đề</th>
                                <th>Danh mục</th>
                                <th>Nổi bật ?</th>
                                <th>Giá</th>
                                <th>Giảm giá</th>
                                <th>Size</th>
                                <th>Tình trạng</th>
                                <th>Thương hiệu</th>
                                <th>Kho</th>
                                <th>Ảnh</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>STT</th>
                                <th>Tiêu đề</th>
                                <th>Danh mục</th>
                                <th>Nổi bật ?</th>
                                <th>Giá</th>
                                <th>Giảm giá</th>
                                <th>Size</th>
                                <th>Tình trạng</th>
                                <th>Thương hiệu</th>
                                <th>Kho</th>
                                <th>Ảnh</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </tfoot>
                        <tbody>

                            @foreach ($products as $product)
                                @php
                                    $sub_cat_info = DB::table('categories')
                                        ->select('title')
                                        ->where('id', $product->child_cat_id)
                                        ->get();
                                    // dd($sub_cat_info);
                                    $brands = DB::table('brands')
                                        ->select('title')
                                        ->where('id', $product->brand_id)
                                        ->get();
                                @endphp
                                <tr>
                                    <td>{{ $product->id }}</td>
                                    <td>{{ $product->title }}</td>
                                    <td>{{ $product->cat_info['title'] }}
                                        <sub>
                                            /{{ $product->sub_cat_info->title ?? '' }}
                                        </sub>
                                    </td>
                                    <td>{{ $product->is_featured == 1 ? 'Yes' : 'No' }}</td>
                                    <td>{{ $product->price }} đ</td>
                                    <td>{{ $product->discount }}%</td>
                                    <td>{{ $product->size }}</td>
                                    <td>{{ $product->condition }}</td>
                                    <td> {{ ucfirst($product->brand->title) }}</td>
                                    <td>
                                        @if ($product->stock > 0)
                                            <span class="badge badge-primary">{{ $product->stock }}</span>
                                        @else
                                            <span class="badge badge-danger">{{ $product->stock }}</span>
                                        @endif
                                    </td>
                                    <td>
                                        @if ($product->photo)
                
                                            <img src="{{ asset($product->photo) }}" class="img-fluid zoom" style="max-width:80px"
                                                alt="{{ $product->photo }}">
                                        @else
                                            <img src="{{ asset('backend/img/thumbnail-default.jpg') }}" class="img-fluid"
                                                style="max-width:80px" alt="avatar.png">
                                        @endif
                                    </td>
                                    <td>
                                        @if ($product->status == 'active')
                                            <span class="badge badge-success">Hoạt Động</span>
                                        @else
                                            <span class="badge badge-warning">Ngưng Hoạt Động</span>
                                        @endif
                                    </td>
                                    <td>
                                        <a href="{{ route('product.edit', $product->id) }}"
                                            class="btn btn-primary btn-sm float-left mr-1"
                                            style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip"
                                            title="edit" data-placement="bottom"><i class="fas fa-edit"></i></a>
                                        <form method="POST" action="{{ route('product.destroy', [$product->id]) }}">
                                            @csrf
                                            @method('delete')
                                            <button class="btn btn-danger btn-sm dltBtn" data-id={{ $product->id }}
                                                style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip"
                                                data-placement="bottom" title="Delete"><i
                                                    class="fas fa-trash-alt"></i></button>
                                        </form>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                @else
                    <h6 class="text-center">Không có sản phẩm nào !!! Vui lòng tạo thêm</h6>
                @endif
            </div>
        </div>
    </div>
@endsection

@push('styles')
    <style>
        .zoom {
            transition: transform .2s;
            /* Animation */
        }

        .zoom:hover {
            transform: scale(5);
        }
    </style>
@endpush

@push('scripts')
    <script>
        $(document).ready(function() {
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });
            var table = $('.table').DataTable({
                language: {
                    "sEmptyTable": "Không có dữ liệu",
                    "sInfo": "Hiển thị _START_ đến _END_ của _TOTAL_ bản ghi",
                    "sInfoEmpty": "Hiển thị 0 đến 0 của 0 bản ghi",
                    "sInfoFiltered": "(được lọc từ _MAX_ tổng số bản ghi)",
                    "sInfoPostFix": "",
                    "sInfoThousands": ",",
                    "sLengthMenu": "Hiển thị _MENU_ bản ghi",
                    "sLoadingRecords": "Đang tải...",
                    "sProcessing": "Đang xử lý...",
                    "sSearch": "Tìm kiếm:",
                    "sZeroRecords": "Không tìm thấy kết quả nào phù hợp",
                    "oPaginate": {
                        "sFirst": "Đầu",
                        "sLast": "Cuối",
                        "sNext": "Tiếp",
                        "sPrevious": "Trước"
                    },
                    "oAria": {
                        "sSortAscending": ": Sắp xếp tăng dần",
                        "sSortDescending": ": Sắp xếp giảm dần"
                    }
                },
                dom: 'Bfrtip',
                buttons: [{
                        extend: 'copy',
                        text: 'Sao chép'
                    },
                    {
                        extend: 'excel',
                        text: 'Xuất Excel'
                    },
                    {
                        extend: 'pdf',
                        text: 'Xuất PDF'
                    },
                    {
                        extend: 'print',
                        text: 'In'
                    },
                    {
                        extend: 'colvis',
                        text: 'Hiển thị cột'
                    },
                    {
                        extend: 'pageLength',
                        text: 'Số bản ghi trên trang'
                    }
                ],
            });
            $('.dltBtn').click(function(e) {
                var form = $(this).closest('form');
                var dataID = $(this).data('id');
                e.preventDefault();
                Swal.fire({
                    title: "Bạn có chắc không?",
                    text: "Khi xóa sẽ không thể khôi phục dữ liệu!",
                    icon: "warning",
                    showDenyButton: true,
                    confirmButtonText: "Xóa",
                    denyButtonText: `Hủy`
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    } else if (result.isDenied) {
                        Swal.fire("Dữ liệu an toàn!", "", "info");
                    }
                });
            })
        })
    </script>
@endpush
