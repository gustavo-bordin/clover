import 'package:flutter/material.dart';

import 'package:clover/common/constants.dart';
import 'package:clover/common/widgets/custom_button.dart';
import 'package:clover/common/widgets/text_title.dart';
import 'package:clover/views/session/widgets/text_secondary.dart';

class BuyModal extends StatefulWidget {
  const BuyModal({
    super.key,
    required this.cloversAmount,
    required this.leafsAmount,
    required this.price,
  });

  final int cloversAmount;
  final int leafsAmount;
  final double price;

  @override
  State<BuyModal> createState() => _BuyModalState();
}

class _BuyModalState extends State<BuyModal> {
  late int _localCloversAmount;
  late int _localLeafsAmount;
  late double _localPrice;
  int amount = 1;

  @override
  void initState() {
    super.initState();
    _localCloversAmount = widget.cloversAmount;
    _localLeafsAmount = widget.leafsAmount;
    _localPrice = widget.price;
  }

  void increment() {
    setState(() {
      amount += 1;
      _localCloversAmount += widget.cloversAmount;
      _localLeafsAmount += widget.leafsAmount;
      _localPrice += widget.price;
    });
  }

  void decrement() {
    if (amount > 1) {
      setState(() {
        amount -= 1;
        _localCloversAmount -= widget.cloversAmount;
        _localLeafsAmount -= widget.leafsAmount;
        _localPrice -= widget.price;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const TextTitle(text: "Adicionar pacote!"),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextSecondary(
                    text: "Voce esta adicionando $_localCloversAmount Trevos e $_localLeafsAmount Folhas a sua conta.",
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Quantidade: $amount",
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Cabin',
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: decrement,
                            style: ButtonStyle(
                              shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                              elevation: const MaterialStatePropertyAll(0),
                              backgroundColor: MaterialStatePropertyAll(ColorConstants.mainGreen),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              "-",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: increment,
                            style: ButtonStyle(
                              shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                              elevation: const MaterialStatePropertyAll(0),
                              backgroundColor: MaterialStatePropertyAll(ColorConstants.mainGreen),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              "+",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            CustomButton(
              text: "Confirmar por R\$ ${_localPrice.toStringAsFixed(2)}",
              onTap: () => {},
              borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
              color: ColorConstants.mainGreen,
            )
          ],
        ),
      ),
    );
  }
}
