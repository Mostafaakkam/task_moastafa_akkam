import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_moastafa_akkam/product/repo/product_bloc/product_bloc.dart';
import 'package:task_moastafa_akkam/product/repo/product_bloc/product_state.dart';
import 'package:task_moastafa_akkam/product/repo/product_bloc/product_event.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = GoogleFonts.poppinsTextTheme(theme.textTheme);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('My Cart', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            final items = state.cartItems; // each has product, qty
            if (items.isEmpty) {
              return const Center(child: Text('Your cart is empty'));
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                final p = item.product;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Color(0x12000000), blurRadius: 14, offset: Offset(0, 8)),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Image.network(
                              p.image ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const ColoredBox(
                                color: Color(0xFFF0F2F7),
                                child: Center(child: Icon(Icons.image_outlined, color: Colors.black54)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.title ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.read<ProductBloc>().add(RemoveFromCartEvent(id: p.id ?? 0));
                                    },
                                    icon: const Icon(Icons.remove_circle_outline),
                                    tooltip: 'Decrease',
                                  ),
                                  Text('Qty: ${item.qty}', style: theme.textTheme.bodyMedium),
                                  IconButton(
                                    onPressed: () {
                                      context.read<ProductBloc>().add(AddToCartEvent(
                                            id: p.id ?? 0,
                                            title: p.title ?? '',
                                            price: p.price ?? 0,
                                            description: p.description ?? '',
                                            category: p.category ?? '',
                                            image: p.image ?? '',
                                          ));
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                    tooltip: 'Increase',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text('\$${(p.price ?? 0).toStringAsFixed(2)}',
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Color(0x15000000), blurRadius: 16, offset: Offset(0, -4))],
          ),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              final total = state.cartTotal;
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Total', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54)),
                        const SizedBox(height: 2),
                        Text('\\${total.toStringAsFixed(2)}',
                            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Checkout not implemented')),
                      );
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
