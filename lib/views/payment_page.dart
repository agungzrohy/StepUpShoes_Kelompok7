import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/utils/price_utils.dart';
import 'home/home.dart';

class PaymentPage extends StatefulWidget {
  final List<CartModel> cartProducts;
  const PaymentPage({super.key, required this.cartProducts});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController addressController = TextEditingController();
  String paymentMethod = 'Transfer Bank';
  final List<String> paymentOptions = [
    'Transfer Bank',
    'E-Wallet',
    'COD',
  ];

  int get totalPrice => widget.cartProducts
      .fold(0, (sum, item) => sum + (item.price * item.ammounts));

  void _showSuccessDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Pesanan Selesai'),
        content: const Text('Pesanan Anda telah selesai!'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Ke Home'),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) => const Home()),
                (route) => false,
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF1565c0),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Pembayaran'),
        backgroundColor: Color(0xFF1565c0),
        border: null,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(CupertinoIcons.creditcard,
                    color: Color(0xFF1565c0), size: 32),
                SizedBox(width: 8),
                Text('Pembayaran',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565c0))),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Daftar Produk',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    const SizedBox(height: 8),
                    ...widget.cartProducts.map((item) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(CupertinoIcons.cube_box,
                                  color: Color(0xFF1565c0)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Text('Jumlah: ${item.ammounts}',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF888888))),
                                  ],
                                ),
                              ),
                              Text(
                                  'IDR ${PriceUtils.formatPrice(item.price * item.ammounts)} K',
                                  style: const TextStyle(
                                      color: Color(0xFF1565c0),
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Alamat Pengiriman',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            controller: addressController,
                            placeholder: 'Masukkan alamat lengkap',
                            padding: const EdgeInsets.all(16),
                            style: const TextStyle(color: Color(0xFF222222)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.08),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Metode Pembayaran',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white)),
                          const SizedBox(height: 8),
                          CupertinoSlidingSegmentedControl<String>(
                            groupValue: paymentMethod,
                            children: {
                              for (var opt in paymentOptions) opt: Text(opt)
                            },
                            onValueChanged: (val) {
                              if (val != null)
                                setState(() => paymentMethod = val);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Detail transaksi
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Subtotal',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF222222))),
                                Text(
                                    'IDR ${PriceUtils.formatPrice(totalPrice)} K',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF222222))),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Ongkir',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF222222))),
                                Text('IDR 20 K',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF222222))),
                              ],
                            ),
                            const Divider(height: 24, thickness: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1565c0))),
                                Text(
                                    'IDR ${PriceUtils.formatPrice(totalPrice + 20000)} K',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1565c0))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 12,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(12),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text('Bayar', style: TextStyle(fontSize: 18)),
                    onPressed: () {
                      _showSuccessDialog();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
