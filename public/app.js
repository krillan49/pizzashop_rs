// Счетчик отдельных покупок для корзины
function addToCart(id) {
    var key = 'product_' + id;
    
    var x = window.localStorage.getItem(key);
    x = x * 1 + 1;
    window.localStorage.setItem(key, x);
}