// Добавление отдельных товаров в корзину
function addToCart(id) {
    var key = 'product_' + id;

    var x = window.localStorage.getItem(key);
    x = x * 1 + 1;
    window.localStorage.setItem(key, x);

    updateOrdersInput();
    updateOrdersButton();
    updateOrderCounter(id);
}

// Удаление отдельных товаров из корзины
function rmFromCart(id) {
    var key = 'product_' + id;

    var x = window.localStorage.getItem(key);
    x = x * 1 - 1;
    if(x < 0) {
        x = 0;
    }
    window.localStorage.setItem(key, x);

    updateOrdersInput();
    updateOrdersButton();
    updateOrderCounter(id);
}

// Для счетчика между кнопками + и - для каждого товара
function updateOrderCounter(id) {
    var order = 0;
    for (var i = 0; i < window.localStorage.length; i++){
        var key = window.localStorage.key(i); // получаем ключ
        var value = window.localStorage.getItem(key); // получаем значение

        if(key == 'product_' + id) {
            order = value * 1;
        }
    }
    $('#counter' + id).val(order);    
}

// Функция для того чтобы обратиться к полю в которое мы хотим поместить "product_1=3,product_2=5,product_3=1, ..." чтобы потом отправить этот результат на сервер.
function updateOrdersInput() {
    var orders = сartGetOrders();
    $('#orders_input').val(orders);    
}

// Функция для того чтобы обратиться к кнопке в имя которой мы хотим поместить общее число заказов чтобы информацию о заказах было видно клиенту.
function updateOrdersButton() {
    var text = 'Корзина (' + cartGetNumberOfItems() + ' шт.)';
    $('#orders_button').val(text);
}

// Счетчик для общего количества товаров в корзине:
function cartGetNumberOfItems() {
    var cnt = 0;
    for (var i = 0; i < window.localStorage.length; i++){
        var key = window.localStorage.key(i); // получаем ключ
        var value = window.localStorage.getItem(key); // получаем значение

        if(key.indexOf('product_') == 0) {
            cnt = cnt + value * 1;
        }
    }
    return cnt;
}

// Функция для получения(и дальнейшей отправки через форму на сервер) результата о заказах из localStorage вида "product_1=3,product_2=5,product_3=1, ..."
function сartGetOrders() {
    var orders = '';
    for (var i = 0; i < window.localStorage.length; i++){
        var key = window.localStorage.key(i); // получаем ключ
        var value = window.localStorage.getItem(key); // получаем значение

        if(key.indexOf('product_') == 0) {
            orders = orders + key + '=' + value + ','; //  "product_1=3,"
        }
    }
    return orders; // "product_1=3,product_2=5,product_3=1, ..."
}

// Для очистки козины на странице подтвержден
function canselOrder() {
    window.localStorage.clear();
    updateOrdersInput();
    updateOrdersButton();
    $('#cart').text('Your cart is now empty');
}