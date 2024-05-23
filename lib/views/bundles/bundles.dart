import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:clover/bloc/session.bloc.dart';
import 'package:clover/common/bloc_handlers.dart';
import 'package:clover/common/constants.dart';
import 'package:clover/common/widgets/custom_button.dart';
import 'package:clover/common/widgets/loading_layer.dart';
import 'package:clover/common/widgets/text_title.dart';
import 'package:clover/models/user.dart';
import 'package:clover/views/bundles/widgets/buy_modal.dart';
import 'package:clover/views/session/widgets/text_secondary.dart';

part 'widgets/bundle.dart';

class Bundles extends StatefulWidget {
  final UserModel user;

  const Bundles({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _BundlesState();
}

class _BundlesState extends State<Bundles> {
  void _logout() {
    Navigator.pop(context);
    // context.read<SessionCubit>().logout();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionCubit, SessionState>(
      listener: (context, state) {
        switch (state) {
          case SessionFailure _:
            handleFailure(context, state.failure);
        }
      },
      builder: (context, state) {
        return LoadingLayer(
          isLoading: state is SessionLoading,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(color: ColorConstants.mainGreen),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => {},
                                  child: const Image(
                                    image: AssetConstants.cloverOnlyLogoWhite,
                                    width: 30,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {},
                                  child: const FaIcon(
                                    FontAwesomeIcons.bell,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                            child: Row(
                              children: [
                                const Text(
                                  "Bem vindo,  ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                Text(
                                  "${widget.user.name}.",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        const TextTitle(text: "Trevos de graça!"),
                        const SizedBox(height: 20),
                        const TextSecondary(
                          text:
                              "Assista a um anuncio rapido e receba 1 Trevo + 1 Folha, essa e sua chance de sair por cima sem gastar NADA!",
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: "Ganhar agora!",
                          onTap: () => {},
                          icon: FontAwesomeIcons.clapperboard,
                          borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
                          color: ColorConstants.mainGreen,
                        ),
                        const SizedBox(height: 40),
                        const TextTitle(text: "Pacotes acessiveis"),
                        const SizedBox(height: 20),
                        const TextSecondary(
                          text:
                              "Quer ganhar aquela vantagem sem gastar muito? Aqui estao os pacotes acessiveis, aproveite!",
                        ),
                        const SizedBox(height: 40),
                        const Bundle(
                          cloversAmount: 50,
                          leafsAmount: 80,
                          isRecommended: true,
                          price: 34.90,
                        ),
                        const SizedBox(height: 20),
                        const Bundle(
                          cloversAmount: 20,
                          leafsAmount: 25,
                          price: 14.90,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(height: 40),
                        const TextTitle(text: "Pacotes avançados"),
                        const SizedBox(height: 20),
                        const TextSecondary(
                          text:
                              "Com esses pacotes voce ganha muita vantagem em trevos e folhas, com tudo isso fica facil ganhar premios!",
                        ),
                        const SizedBox(height: 40),
                        const Bundle(
                          cloversAmount: 200,
                          leafsAmount: 320,
                          isRecommended: true,
                          price: 139.90,
                        ),
                        const SizedBox(height: 20),
                        const Bundle(
                          cloversAmount: 100,
                          leafsAmount: 130,
                          price: 69.90,
                        ),
                        const SizedBox(height: 40),
                        const TextTitle(text: "Pacotes PREMIUM"),
                        const SizedBox(height: 20),
                        const TextSecondary(
                          text:
                              "Nossa! com tudo isso voce vai sair na frente de todo mundo, aposto que ninguem tera tantas folhas como voce!",
                        ),
                        const SizedBox(height: 40),
                        const Bundle(
                          cloversAmount: 800,
                          leafsAmount: 900,
                          isRecommended: true,
                          price: 519.90,
                        ),
                        const SizedBox(height: 20),
                        const Bundle(
                          cloversAmount: 400,
                          leafsAmount: 400,
                          price: 279.90,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
