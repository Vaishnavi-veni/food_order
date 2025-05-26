import 'package:e_commerce/screens/confirm_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/order_bloc.dart';

class OrderScreen2 extends StatelessWidget {
  const OrderScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (_) => OrderBloc(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageHeader(),
                  const SizedBox(height: 10),
                  _buildDishInfo(),
                  const Divider(),
                  _buildAddOnSection(context),
                  const Divider(),
                  _buildChooseProteinSection(context),
                  const SizedBox(height: 20),
                  _buildBottomBar(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/home/food/Healthy.png',
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildDishInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Plant Protein Bowl',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Row(
              children: List.generate(
                4,
                (index) =>
                    const Icon(Icons.star, color: Colors.amber, size: 16),
              )..add(
                  const Icon(Icons.star_half, color: Colors.amber, size: 16)),
            ),
            const SizedBox(width: 4),
            const Text('11'),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(4),
                color: Colors.red.shade50,
              ),
              child: const Text(
                'Bestseller',
                style: TextStyle(fontSize: 10, color: Colors.red),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          '[Veg preparation] Spring mix, plant based, organic..',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildAddOnSection(BuildContext context) {
    final addOns = [
      'Pesto Paneer',
      'Paneer',
      'Extra Veggies',
      'Mushroom',
      'Corn',
      'Chilli Paneer',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Add On',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const Text('You can choose up to 4 options'),
        const SizedBox(height: 10),
        ...addOns.map((item) {
          return _buildCheckboxItem(context, item, 40);
        }),
      ],
    );
  }

  Widget _buildChooseProteinSection(BuildContext context) {
    final proteins = ['BBQ Protein', 'Chilli Paneer'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose Your Protein',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const Text('You can choose up to 3 options'),
        const SizedBox(height: 10),
        ...proteins.map((item) => _buildCheckboxItem(context, item, 40)),
      ],
    );
  }

  Widget _buildCheckboxItem(BuildContext context, String title, int price) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final isSelected =
            state.selectedAddOns.contains(title); // hypothetical list
        return Row(
          children: [
            const Icon(Icons.radio_button_checked,
                color: Colors.green, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(title)),
            Text('₹$price'),
            const SizedBox(width: 10),
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                context.read<OrderBloc>().add(ToggleAddOn(title));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuantityControl(BuildContext context, int quantity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.remove, color: Colors.red),
          onPressed: () => context.read<OrderBloc>().add(DecreaseQuantity()),
        ),
        Text('$quantity'),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.red),
          onPressed: () => context.read<OrderBloc>().add(IncreaseQuantity()),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return Container(
              width: 110,
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(30),
              ),
              child: _buildQuantityControl(context, state.quantity),
            );
          },
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              showConfirmOrderBottomSheet(context);
            },
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                final totalPrice = 279 * state.quantity + state.addOnsPrice;
                return Text('Add ₹$totalPrice',
                    style: const TextStyle(fontSize: 16, color: Colors.white));
              },
            ),
          ),
        ),
      ],
    );
  }

  void showConfirmOrderBottomSheet(BuildContext context) {
    final orderBloc = context.read<OrderBloc>(); // Get existing bloc
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: orderBloc,
        child: const ConfirmOrderScreen(),
      ),
    );
  }
}
