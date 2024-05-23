part of '../bundles.dart';

class Bundle extends StatelessWidget {
  const Bundle({
    super.key,
    required this.cloversAmount,
    required this.leafsAmount,
    this.isRecommended = false,
    required this.price,
  });

  final int cloversAmount;
  final int leafsAmount;
  final bool isRecommended;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
              decoration: BoxDecoration(
                color: ColorConstants.inputFill,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topRight: Radius.circular(20),
                ),
                border: Border.all(
                  color: ColorConstants.secondaryGreen,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Image(
                        image: AssetConstants.cloverOnlyLogoGreen,
                        width: 25,
                      ),
                      const SizedBox(width: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "x$cloversAmount",
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Cabin",
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Trevos",
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.mainGrey,
                              fontFamily: "Cabin",
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.leaf,
                        size: 25,
                        color: ColorConstants.mainGreen,
                      ),
                      const SizedBox(width: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "x$leafsAmount",
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Cabin",
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Folhas",
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.mainGrey,
                              fontFamily: "Cabin",
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            if (isRecommended)
              Positioned(
                left: 20,
                top: -10,
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConstants.secondaryGreen,
                  ),
                  child: const Text(
                    "RECOMENDADO",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Cabin",
                    ),
                  ),
                ),
              ),
          ],
        ),
        CustomButton(
          text: "R\$ ${price.toStringAsFixed(2)}",
          onTap: () => showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
              ),
            ),
            builder: (context) => BuyModal(
              cloversAmount: cloversAmount,
              leafsAmount: leafsAmount,
              price: price,
            ),
          ),
          icon: FontAwesomeIcons.bagShopping,
          borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
          color: ColorConstants.mainGreen,
        ),
      ],
    );
  }
}
