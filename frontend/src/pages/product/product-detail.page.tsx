import { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import {
  Minus, Plus, ShoppingCart, CreditCard, Store,
  Star, ShieldCheck, Truck, RotateCcw, ChevronRight
} from 'lucide-react';

import { getProduct } from '../../shared/api/catalog';

export default function ProductDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();

  const [quantity, setQuantity] = useState(1);
  const [activeImage, setActiveImage] = useState<string>('');

  // 1. CALL API LẤY CHI TIẾT SẢN PHẨM
  const { data: product, isLoading, isError } = useQuery({
    queryKey: ["product", id],
    queryFn: () => getProduct(id!),
    enabled: !!id,
  });

  // 2. XỬ LÝ LỌC SẠCH DẤU NGOẶC NHỌN {} CHO LINK ẢNH TỪ BACKEND
  const p = product as any;
  let rawImage = '';

  if (Array.isArray(p?.imageUrls) && p.imageUrls.length > 0) {
    rawImage = p.imageUrls[0];
  } else if (typeof p?.imageUrl === 'string') {
    rawImage = p.imageUrl;
  } else if (typeof p?.ImageUrls === 'string') {
    rawImage = p.ImageUrls;
  }

  // Dùng Regex gọt bỏ hoàn toàn ký tự { và } bị dư thừa
  const cleanDefaultImage = rawImage && rawImage.trim() !== ''
    ? rawImage.replace(/[{}]/g, '')
    : 'https://placehold.co/600x600/f8fafc/94a3b8?text=Nexus+Product';

  // Danh sách gallery ảnh phụ
  const galleryImages = product ? [
    cleanDefaultImage,
    'https://placehold.co/600x600/f8fafc/94a3b8?text=Goc+Chup+2',
    'https://placehold.co/600x600/f8fafc/94a3b8?text=Goc+Chup+3',
    'https://placehold.co/600x600/f8fafc/94a3b8?text=Goc+Chup+4',
  ] : [];

  // Khởi tạo ảnh mặc định khi load xong data
  useEffect(() => {
    if (product) {
      setActiveImage(cleanDefaultImage);
    }
  }, [product, cleanDefaultImage]);

  if (isLoading) {
    return <div className="min-h-screen flex items-center justify-center">Đang tải thông tin sản phẩm...</div>;
  }

  if (isError || !product) {
    return <div className="min-h-screen flex items-center justify-center text-red-500">Không tìm thấy sản phẩm!</div>;
  }

  // 3. ÉP CỨNG TỒN KHO LÀ 100 ĐỂ MỞ KHÓA NÚT MUA HÀNG VÀ THANH TOÁN
  const currentStock = 100;


  const formattedPrice = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(product.price);

  const handleQuantityChange = (type: 'increase' | 'decrease' | 'input', val?: number) => {
    if (type === 'decrease' && quantity > 1) setQuantity(q => q - 1);
    if (type === 'increase' && quantity < currentStock) setQuantity(q => q + 1);
    if (type === 'input' && val !== undefined) {
      if (val >= 1 && val <= currentStock) setQuantity(val);
      else if (val > currentStock) setQuantity(currentStock);
    }
  };

  const handleAddToCart = () => {
    alert(`Đã thêm ${quantity} sản phẩm "${product.name}" vào giỏ hàng!`);
  };

  const handleBuyNow = () => {
    navigate('/checkout');
  };

  return (
    <div className="bg-gray-50 min-h-screen pb-12">
      {/* ── Breadcrumb ── */}
      <div className="max-w-7xl mx-auto px-4 py-4 flex items-center gap-2 text-sm text-gray-500">
        <Link to="/" className="hover:text-nexus-600 transition-colors">Trang chủ</Link>
        <ChevronRight size={14} />
        <span className="text-gray-400 truncate">{product.name}</span>
      </div>

      <div className="max-w-7xl mx-auto px-4">
        <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-0">

            {/* ── BÊN TRÁI: GALLERY ẢNH ────────────────────────────── */}
            <div className="p-6 md:p-8 border-r border-gray-100">
              <div className="aspect-square bg-gray-50 rounded-xl overflow-hidden mb-4 relative">
                <img
                  src={activeImage || cleanDefaultImage}
                  alt={product.name}
                  className="w-full h-full object-cover transition-opacity duration-300"
                  onError={(e) => {
                    const t = e.target as HTMLImageElement;
                    t.src = 'https://placehold.co/600x600/f8fafc/94a3b8?text=Nexus+Product';
                  }}
                />
              </div>

              {/* Thumbnail List */}
              <div className="grid grid-cols-4 gap-3">
                {galleryImages.map((img, idx) => (
                  <button
                    key={idx}
                    onClick={() => setActiveImage(img)}
                    className={`aspect-square rounded-lg overflow-hidden border-2 transition-all ${activeImage === img ? 'border-nexus-500 shadow-md' : 'border-transparent opacity-70 hover:opacity-100'}`}
                  >
                    <img src={img} alt={`thumbnail-${idx}`} className="w-full h-full object-cover" />
                  </button>
                ))}
              </div>
            </div>

            {/* ── BÊN PHẢI: THÔNG TIN CHI TIẾT ──────────────────────── */}
            <div className="p-6 md:p-8 flex flex-col">

              {/* Tên & Giá */}
              <h1 className="text-2xl font-bold text-gray-900 mb-2">{product.name}</h1>
              <div className="flex items-end gap-4 mb-6 pb-6 border-b border-gray-100">
                <span className="text-3xl font-extrabold text-nexus-600">{formattedPrice}</span>
                <span className="text-sm text-gray-500 mb-1">
                  Đã bán: 120 | Kho: <strong className="text-green-600">{currentStock}</strong>
                </span>
              </div>

              {/* Thông tin Shop (Mockup) */}
              <div className="flex items-center justify-between bg-nexus-50/50 p-4 rounded-xl border border-nexus-100 mb-6">
                <div className="flex items-center gap-3">
                  <div className="w-12 h-12 bg-white rounded-full flex items-center justify-center shadow-sm border border-gray-200">
                    <Store className="text-nexus-500" size={24} />
                  </div>
                  <div>
                    <h3 className="font-semibold text-gray-800 text-sm">Cửa hàng ID: {product.sellerId}</h3>
                    <div className="flex items-center text-xs text-yellow-500 mt-1">
                      <Star size={12} fill="currentColor" />
                      <Star size={12} fill="currentColor" />
                      <Star size={12} fill="currentColor" />
                      <Star size={12} fill="currentColor" />
                      <Star size={12} className="text-gray-300" />
                      <span className="text-gray-500 ml-1">(4.0)</span>
                    </div>
                  </div>
                </div>
                <button className="px-4 py-1.5 text-xs font-medium text-nexus-600 border border-nexus-200 rounded-lg bg-white hover:bg-nexus-50 transition-colors">
                  Xem Shop
                </button>
              </div>

              {/* Mô tả ngắn */}
              <div className="mb-6 flex-1">
                <h3 className="font-semibold text-gray-800 mb-2">Mô tả sản phẩm</h3>
                <p className="text-gray-600 text-sm leading-relaxed whitespace-pre-wrap">
                  {product.description || 'Chưa có mô tả cho sản phẩm này.'}
                </p>
              </div>

              {/* Khối Thao tác: Số lượng & Nút bấm */}
              <div className="bg-gray-50 p-4 rounded-xl border border-gray-100 mt-auto">
                <div className="flex flex-col sm:flex-row gap-4">

                  {/* Cụm chọn số lượng */}
                  <div className="flex items-center bg-white border border-gray-200 rounded-xl overflow-hidden h-12">
                    <button
                      onClick={() => handleQuantityChange('decrease')}
                      disabled={quantity <= 1}
                      className="w-10 h-full flex items-center justify-center text-gray-500 hover:bg-gray-100 disabled:opacity-50 transition-colors"
                    >
                      <Minus size={16} />
                    </button>
                    <input
                      type="number"
                      value={quantity}
                      onChange={(e) => handleQuantityChange('input', parseInt(e.target.value) || 1)}
                      className="w-12 h-full text-center text-sm font-medium focus:outline-none focus:ring-0"
                    />
                    <button
                      onClick={() => handleQuantityChange('increase')}
                      disabled={quantity >= currentStock}
                      className="w-10 h-full flex items-center justify-center text-gray-500 hover:bg-gray-100 disabled:opacity-50 transition-colors"
                    >
                      <Plus size={16} />
                    </button>
                  </div>

                  {/* Nút hành động */}
                  <div className="flex flex-1 gap-3">
                    <button
                      onClick={handleAddToCart}
                      className="flex-1 flex items-center justify-center gap-2 bg-nexus-50 text-nexus-600 border border-nexus-200 rounded-xl h-12 font-semibold text-sm hover:bg-nexus-100 transition-colors"
                    >
                      <ShoppingCart size={18} /> Thêm vào giỏ
                    </button>
                    <button
                      onClick={handleBuyNow}
                      className="flex-1 flex items-center justify-center gap-2 bg-nexus-600 text-white rounded-xl h-12 font-semibold text-sm hover:bg-nexus-700 shadow-md shadow-nexus-500/20 transition-all"
                    >
                      <CreditCard size={18} /> Mua ngay
                    </button>
                  </div>

                </div>
              </div>

              {/* Trust badges footer */}
              <div className="flex items-center justify-between gap-2 mt-4 pt-4 border-t border-gray-100 text-xs text-gray-500">
                <div className="flex items-center gap-1.5"><ShieldCheck size={16} className="text-green-500"/> Chính hãng 100%</div>
                <div className="flex items-center gap-1.5"><Truck size={16} className="text-blue-500"/> Giao toàn quốc</div>
                <div className="flex items-center gap-1.5"><RotateCcw size={16} className="text-orange-500"/> Đổi trả 7 ngày</div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </div>
  );
}