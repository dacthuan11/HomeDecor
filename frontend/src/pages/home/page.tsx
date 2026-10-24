import { useState, useEffect } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import { Search, SlidersHorizontal, X, Truck, Shield, RotateCcw, Tag, Gavel, Loader2 } from 'lucide-react';
import { useQuery } from '@tanstack/react-query';

// Import Component & API
import ProductCard from '../../shared/ui/ProductCard';
import { getCategories, getProducts } from '../../shared/api/catalog';

export default function HomePage() {
  const [searchParams, setSearchParams] = useSearchParams();

  // 1. Lấy các tham số từ URL
  const urlSearch = searchParams.get('search') || '';
  const urlCat = searchParams.get('category') || '';
  const urlPage = parseInt(searchParams.get('page') || '1');
  const urlMinPrice = searchParams.get('minPrice') || '';
  const urlMaxPrice = searchParams.get('maxPrice') || '';
  const urlSort = searchParams.get('sort') || 'newest';

  // Kiểm tra xem người dùng có đang dùng bộ lọc/tìm kiếm hay không
  const isFiltered = !!urlSearch || !!urlCat || !!urlMinPrice || !!urlMaxPrice;

  // State cục bộ cho các ô input lọc giá & sắp xếp
  const [minPrice, setMinPrice] = useState(urlMinPrice);
  const [maxPrice, setMaxPrice] = useState(urlMaxPrice);
  const [sortBy, setSortBy] = useState(urlSort);

  // Đồng bộ UI input với URL khi user điều hướng (VD: bấm nút Back của trình duyệt)
  useEffect(() => {
    setMinPrice(urlMinPrice);
    setMaxPrice(urlMaxPrice);
    setSortBy(urlSort);
  }, [urlMinPrice, urlMaxPrice, urlSort]);

  // 2. GỌI API LẤY DANH MỤC SẢN PHẨM
  const { data: categories = [] } = useQuery({
    queryKey: ["categories"],
    queryFn: getCategories
  });

  // 3. GỌI API LẤY DANH SÁCH SẢN PHẨM THEO BỘ LỌC
  const { data: productData, isLoading } = useQuery({
    queryKey: ["products", { urlSearch, urlCat, urlMinPrice, urlMaxPrice, urlSort, urlPage }],
    queryFn: () => getProducts({
      search: urlSearch,
      categoryId: urlCat,
      minPrice: urlMinPrice,
      maxPrice: urlMaxPrice,
      sort: urlSort,
      page: urlPage,
      pageSize: 10
    })
  });

  // Trích xuất dữ liệu từ Response của Backend
  const products = productData?.items || [];
  // Tính tổng số trang dựa trên totalCount và pageSize
  const totalPages = Math.max(1, Math.ceil((productData?.totalCount || 0) / (productData?.pageSize || 10)));

  // 4. CÁC HÀM XỬ LÝ SỰ KIỆN
  const handleApplyFilter = () => {
    const params = new URLSearchParams(searchParams);
    if (minPrice) params.set('minPrice', minPrice);
    else params.delete('minPrice');

    if (maxPrice) params.set('maxPrice', maxPrice);
    else params.delete('maxPrice');

    if (sortBy) params.set('sort', sortBy);

    params.set('page', '1'); // Lọc lại thì reset về trang 1
    setSearchParams(params);
  };

  const handleClearFilters = () => {
    setMinPrice('');
    setMaxPrice('');
    setSortBy('newest');

    // Xóa lọc giá và sắp xếp, giữ lại search keyword và danh mục (nếu có)
    const params = new URLSearchParams();
    if (urlSearch) params.set('search', urlSearch);
    if (urlCat) params.set('category', urlCat);
    setSearchParams(params);
  };

  const clearAllFilters = () => {
    // Trở về trang chủ nguyên bản, xóa sạch mọi query params
    setSearchParams(new URLSearchParams());
  };

  return (
    <div className="bg-gray-50 min-h-screen pb-12">

      {/* ── 1. HERO BANNER (Chỉ hiện khi chưa lọc/tìm kiếm) ────────── */}
      {!isFiltered && (
        <div className="bg-gradient-to-r from-nexus-800 via-nexus-700 to-nexus-500 py-10">
          <div className="max-w-7xl mx-auto px-4 flex flex-col md:flex-row items-center gap-8">
            <div className="text-white flex-1">
              <p className="text-nexus-200 text-sm font-medium mb-1 uppercase tracking-wider">Chào mừng đến với</p>
              <h1 className="text-3xl md:text-4xl font-extrabold mb-3">Nexus Marketplace</h1>
              <p className="text-nexus-100 text-base mb-6 max-w-lg">Mua sắm, đấu giá và nhận ưu đãi tốt nhất — Giao nhanh toàn quốc, đổi trả dễ dàng.</p>
              <div className="flex flex-wrap gap-3">
                <Link to="/auctions" className="bg-white text-nexus-700 px-5 py-2.5 rounded-xl font-bold text-sm hover:bg-nexus-50 transition-colors flex items-center gap-2">
                  <Gavel size={16} /> Tham gia đấu giá
                </Link>
                <button
                  onClick={() => setSearchParams({ search: "laptop" })}
                  className="border border-white/40 text-white px-5 py-2.5 rounded-xl font-medium text-sm hover:bg-white/10 transition-colors"
                >
                  Khám phá ngay →
                </button>
              </div>
            </div>
            <div className="grid grid-cols-2 gap-3 shrink-0">
              {[
                { icon: <Truck size={18} />, label: "Giao hàng toàn quốc", sub: "Từ 30.000đ" },
                { icon: <Shield size={18} />, label: "Bảo đảm chính hãng", sub: "100% authentic" },
                { icon: <RotateCcw size={18} />, label: "Đổi trả 7 ngày", sub: "Không cần lý do" },
                { icon: <Tag size={18} />, label: "Giá tốt nhất", sub: "So sánh 1000+ shop" },
              ].map(b => (
                <div key={b.label} className="bg-white/10 backdrop-blur rounded-xl p-3 flex items-center gap-2 text-white">
                  <span className="text-nexus-200">{b.icon}</span>
                  <div>
                    <p className="text-xs font-semibold">{b.label}</p>
                    <p className="text-[10px] text-nexus-200">{b.sub}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* ── 2. THANH DANH MỤC ────────────────────────────────────────── */}
      <div className="max-w-7xl mx-auto px-4 mt-8">
        <h2 className="text-lg font-bold text-gray-800 mb-4">{isFiltered ? 'Kết quả tìm kiếm' : 'Danh mục nổi bật'}</h2>
        <div className="flex gap-3 overflow-x-auto pb-2 scrollbar-hide">
          <button
            onClick={clearAllFilters}
            className={`px-5 py-2 rounded-full whitespace-nowrap text-sm font-medium transition-colors ${
              !urlCat ? 'bg-nexus-600 text-white shadow-md' : 'bg-white text-gray-600 border border-gray-200 hover:bg-gray-50'
            }`}
          >
            Tất cả sản phẩm
          </button>

          {categories.map((cat: any) => (
            <button
              key={cat.categoryId}
              onClick={() => {
                const params = new URLSearchParams(searchParams);
                params.set('category', cat.categoryId);
                params.set('page', '1');
                setSearchParams(params);
              }}
              className={`px-5 py-2 rounded-full whitespace-nowrap text-sm font-medium transition-colors ${
                urlCat === cat.categoryId ? 'bg-nexus-600 text-white shadow-md' : 'bg-white text-gray-600 border border-gray-200 hover:bg-gray-50'
              }`}
            >
              {cat.name}
            </button>
          ))}
        </div>
      </div>

      {/* ── 3. FLASH SALE & ĐẤU GIÁ (Chỉ hiện khi chưa lọc) ──────────── */}
      {!isFiltered && products.length >= 4 && (
        <div className="max-w-7xl mx-auto px-4 mt-8 grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Flash Sale */}
          <div className="bg-gradient-to-br from-red-50 to-white rounded-2xl p-6 border border-red-100 shadow-sm relative overflow-hidden">
            <div className="absolute top-0 right-0 w-32 h-32 bg-red-500 opacity-5 rounded-bl-full pointer-events-none"></div>
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-extrabold text-red-600 flex items-center gap-2">🔥 Flash Sale</h2>
              <span className="bg-red-100 text-red-700 text-xs font-bold px-3 py-1 rounded-full">Sắp kết thúc</span>
            </div>
            <div className="grid grid-cols-2 gap-4">
              {products.slice(0, 2).map((product: any) => (
                <ProductCard key={`flash-${product.productId}`} product={product} />
              ))}
            </div>
          </div>

          {/* Đấu giá */}
          <div className="bg-gradient-to-br from-purple-50 to-white rounded-2xl p-6 border border-purple-100 shadow-sm relative overflow-hidden">
            <div className="absolute top-0 right-0 w-32 h-32 bg-purple-500 opacity-5 rounded-bl-full pointer-events-none"></div>
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-extrabold text-purple-700 flex items-center gap-2">🔨 Đấu giá nổi bật</h2>
              <Link to="/auctions" className="text-sm font-medium text-purple-600 hover:underline">Xem tất cả &rarr;</Link>
            </div>
            <div className="grid grid-cols-2 gap-4">
              {products.slice(2, 4).map((product: any) => (
                <ProductCard key={`auction-${product.productId}`} product={product} />
              ))}
            </div>
          </div>
        </div>
      )}

      {/* ── 4. THANH BỘ LỌC GIÁ & SẮP XẾP ────────────────────────────── */}
      <div className="max-w-7xl mx-auto px-4 mt-8 mb-6">
        <div className="bg-white p-4 rounded-2xl shadow-sm border border-gray-100 flex flex-wrap items-center justify-between gap-4">
          <div className="flex items-center gap-3">
            <SlidersHorizontal size={18} className="text-gray-500" />
            <span className="text-sm font-medium text-gray-700">Khoảng giá:</span>
            <input
              type="number" placeholder="TỪ" value={minPrice} onChange={(e) => setMinPrice(e.target.value)}
              className="w-24 px-3 py-1.5 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-nexus-500"
            />
            <span className="text-gray-400">-</span>
            <input
              type="number" placeholder="ĐẾN" value={maxPrice} onChange={(e) => setMaxPrice(e.target.value)}
              className="w-24 px-3 py-1.5 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-nexus-500"
            />
            <button onClick={handleApplyFilter} className="px-4 py-1.5 bg-nexus-600 text-white text-sm font-medium rounded-lg hover:bg-nexus-700 transition-colors">
              Áp dụng
            </button>
          </div>

          <div className="flex items-center gap-3">
            <span className="text-sm font-medium text-gray-700">Sắp xếp:</span>
            <select
              value={sortBy}
              onChange={(e) => {
                setSortBy(e.target.value);
                const params = new URLSearchParams(searchParams);
                params.set('sort', e.target.value);
                setSearchParams(params);
              }}
              className="px-3 py-1.5 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-nexus-500 cursor-pointer"
            >
              <option value="newest">Mới nhất</option>
              <option value="price_asc">Giá tăng dần</option>
              <option value="price_desc">Giá giảm dần</option>
            </select>

            {(urlMinPrice || urlMaxPrice || urlSort !== 'newest') && (
              <button onClick={handleClearFilters} className="flex items-center gap-1 text-sm text-red-500 hover:text-red-700 px-2">
                <X size={16} /> Bỏ lọc
              </button>
            )}
          </div>
        </div>
      </div>

      {/* ── 5. LƯỚI SẢN PHẨM & EMPTY STATE ────────────────────────────── */}
      <div className="max-w-7xl mx-auto px-4">
        {isLoading ? (
          <div className="flex justify-center py-20">
            <Loader2 className="animate-spin text-nexus-500" size={40} />
          </div>
        ) : products.length === 0 ? (
          <div className="bg-white rounded-2xl p-12 flex flex-col items-center justify-center text-center shadow-sm border border-gray-100">
            <div className="bg-gray-50 p-4 rounded-full mb-4">
              <Search size={40} className="text-gray-400" />
            </div>
            <h3 className="text-lg font-semibold text-gray-800 mb-2">Không tìm thấy sản phẩm nào</h3>
            <p className="text-gray-500 mb-6 max-w-md">Rất tiếc, không có sản phẩm nào phù hợp với tìm kiếm của bạn. Hãy thử thay đổi bộ lọc.</p>
            <button onClick={clearAllFilters} className="px-6 py-2.5 bg-nexus-600 text-white font-medium rounded-xl hover:bg-nexus-700 transition-colors">
              Trở về trang chủ
            </button>
          </div>
        ) : (
          <>
            {!isFiltered && <h2 className="text-lg font-bold text-gray-800 mb-4 mt-6">Dành riêng cho bạn</h2>}
            <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-4">
              {products.map((product: any) => (
                <ProductCard key={product.productId} product={product} />
              ))}
            </div>
          </>
        )}
      </div>

      {/* ── 6. PHÂN TRANG ──────────────────────────────────────────────── */}
      {products.length > 0 && totalPages > 1 && (
        <div className="max-w-7xl mx-auto px-4 mt-10 flex justify-center items-center gap-2">
          <button
            disabled={urlPage <= 1}
            onClick={() => { const params = new URLSearchParams(searchParams); params.set('page', (urlPage - 1).toString()); setSearchParams(params); }}
            className="px-4 py-2 rounded-lg border border-gray-200 bg-white text-gray-600 font-medium hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Trước
          </button>
          <span className="px-4 py-2 text-sm font-medium text-gray-700">Trang {urlPage} / {totalPages}</span>
          <button
            disabled={urlPage >= totalPages}
            onClick={() => { const params = new URLSearchParams(searchParams); params.set('page', (urlPage + 1).toString()); setSearchParams(params); }}
            className="px-4 py-2 rounded-lg border border-gray-200 bg-white text-gray-600 font-medium hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Sau
          </button>
        </div>
      )}

    </div>
  );
}