import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/order_bloc.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    child: BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _header(context),
                          const SizedBox(height: 16),
                          _deliveryInfo(),
                          _itemRow(context, state),
                          _cookingInstructions(),
                          const Divider(),
                          _promoCodeSection(),
                          const Divider(),
                          _tipValetSection(context),
                          const Divider(),
                          _chargesSection(state),
                          const Divider(),
                          _covidCheckbox(),
                          const Divider(),
                          _deliveryInstructionsSection(),
                          _yourDetailsSection(),
                          _climateInfoSection(),
                          const SizedBox(height: 80), // space for button
                        ],
                      );
                    })),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // confirm order logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Confirm Order"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _header(BuildContext context) {
    return AppBar(
      title: const Text('Eat Healthy'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _deliveryInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Delivery at Home - Flat no: 301...",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Delivery in 42 mins"),
      ],
    );
  }

  Widget _itemRow(BuildContext context, OrderState state) {
    return Row(
      children: [
        const Expanded(
          child: Text("Plant Protein Bowl", style: TextStyle(fontSize: 16)),
        ),
        Container(
          width: 110,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.red),
                onPressed: () =>
                    context.read<OrderBloc>().add(DecreaseQuantity()),
              ),
              Text('${state.quantity}'),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.red),
                onPressed: () =>
                    context.read<OrderBloc>().add(IncreaseQuantity()),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text("₹${279 * state.quantity}"),
      ],
    );
  }

  Widget _cookingInstructions() {
    return const TextField(
      decoration: InputDecoration(
        labelText: "Add cooking instructions (optional)",
      ),
    );
  }

  Widget _promoCodeSection() {
    return ListTile(
      title: const Text("Select a promo code"),
      trailing: const Text("View offers", style: TextStyle(color: Colors.red)),
      subtitle: const Text("Save ₹59.70 with code ZOMSAFETY"),
    );
  }

  Widget _tipValetSection(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Please tip your valet",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [20, 30, 50].map((amount) {
                final isSelected = state.tipAmount == amount;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.red[50] : null,
                      side: BorderSide(
                          color: isSelected ? Colors.red : Colors.grey),
                    ),
                    onPressed: () {
                      context.read<OrderBloc>().add(SetTipEvent(amount));
                    },
                    child: Text("₹$amount",
                        style: TextStyle(
                            color: isSelected ? Colors.red : Colors.black)),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _chargesSection(OrderState state) {
    final itemTotal = 279 * state.quantity; // int
    final deliveryCharge = 30;
    final taxes = 5;
    final donation = 3;
    final tip = state.tipAmount.toDouble();

    final grandTotal = itemTotal + deliveryCharge + taxes + donation + tip;

    String formatPrice(double price) => "₹${price.toStringAsFixed(2)}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _priceRow("Item Total", formatPrice(itemTotal.toDouble())),
        _priceRow("Delivery Charge", formatPrice(deliveryCharge.toDouble())),
        _priceRow("Taxes", formatPrice(taxes.toDouble())),
        _priceRow("Donation ₹3",
            donation > 0 ? formatPrice(donation.toDouble()) : "Add",
            isAction: donation == 0),
        _priceRow("Tip", tip > 0 ? formatPrice(tip) : "Add",
            isAction: tip == 0),
        const Divider(),
        _priceRow("Grand Total", formatPrice(grandTotal), bold: true),
      ],
    );
  }

  static Widget _priceRow(String label, String value,
      {bool isAction = false, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  color: isAction ? Colors.red : Colors.black)),
        ],
      ),
    );
  }

  Widget _covidCheckbox() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.isCovidChecked,
              onChanged: (_) {
                context.read<OrderBloc>().add(ToggleCovidCheckbox());
              },
            ),
            const Expanded(
              child: Text("This order is related to a COVID-19 emergency"),
            ),
          ],
        );
      },
    );
  }

  Widget _deliveryInstructionsSection() {
    return ListTile(
      title: const Text("Delivery instructions"),
      subtitle: const Text("Hand me the Order"),
      trailing: const Text("Change", style: TextStyle(color: Colors.red)),
    );
  }

  Widget _yourDetailsSection() {
    return ListTile(
      title: const Text("Your details"),
      subtitle: const Text("Divya Sigatapu, 9109109109"),
      trailing: const Text("Change", style: TextStyle(color: Colors.red)),
    );
  }

  Widget _climateInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ListTile(
          title: Text("Climate conscious delivery",
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
              "We fund environmental projects to offset the carbon footprint of our deliveries."),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
              "Orders once placed cannot be cancelled and are non-refundable.",
              style: TextStyle(color: Colors.red, fontSize: 12)),
        ),
      ],
    );
  }
}
