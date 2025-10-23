import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_moastafa_akkam/product/model/product_model.dart';
import 'package:task_moastafa_akkam/product/repo/product_bloc/product_bloc.dart';
import 'package:task_moastafa_akkam/product/repo/product_bloc/product_event.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

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
        title: Text('Details', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 720;
            final content = _DetailsContent(product: product);
            if (isWide) {
              return Row(
                children: [
                  Expanded(child: content.imageSection),
                  Expanded(child: content.detailsSection),
                ],
              );
            }
            return content.build(context);
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                final p = product;
                context.read<ProductBloc>().add(AddToCartEvent(
                      id: p.id ?? 0,
                      title: p.title ?? '',
                      price: p.price ?? 0,
                      description: p.description ?? '',
                      category: p.category ?? '',
                      image: p.image ?? '',
                    ));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to cart')),
                );
              },
              icon: const Icon(Icons.add_shopping_cart_outlined),
              label: const Text('Add to Cart'),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsContent {
  final ProductModel product;
  _DetailsContent({required this.product});

  Widget get imageSection => Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Color(0x15000000), blurRadius: 18, offset: Offset(0, 10)),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const aspect = 1.2; // width / height
                final width = constraints.maxWidth.isFinite ? constraints.maxWidth : 300.0;
                final height = width / aspect;
                return SizedBox(
                  width: width,
                  height: height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      product.image ?? '',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image_outlined)),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      });

  Widget get detailsSection => Builder(builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title ?? '', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF7F3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '\$${(product.price ?? 0).toStringAsFixed(2)}',
                      style: textTheme.labelLarge?.copyWith(color: const Color(0xFF1F6E4D), fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Chip(
                    label: Text(product.category ?? ''),
                    backgroundColor: const Color(0xFFF0F2F7),
                    side: BorderSide.none,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Description', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(product.description ?? '', style: textTheme.bodyLarge?.copyWith(color: Colors.black87)),
            ],
          ),
        );
      });

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          imageSection,
          detailsSection,
        ],
      ),
    );
  }
}
