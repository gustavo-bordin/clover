import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/countries.dart';

import 'package:clover/bloc/user.bloc.dart';
import 'package:clover/common/bloc_handlers.dart';
import 'package:clover/common/constants.dart';
import 'package:clover/common/router.dart';
import 'package:clover/common/typedefs.dart';
import 'package:clover/common/widgets/custom_button.dart';
import 'package:clover/common/widgets/loading_layer.dart';
import 'package:clover/common/widgets/text_title.dart';
import 'package:clover/models/user.dart';
import 'package:clover/views/session/widgets/bottom_progress.dart';
import 'package:clover/views/session/widgets/text_secondary.dart';
import 'package:clover/views/session/widgets/text_welcome.dart';

class AskUserData extends StatefulWidget {
  final AppwriteSession session;

  const AskUserData({super.key, required this.session});

  @override
  State<AskUserData> createState() => _AskUserDataState();
}

class _AskUserDataState extends State<AskUserData> {
  var selectedCountry = countries.firstWhere((country) => country.flag == "🇧🇷");
  TextEditingController nameController = TextEditingController();

  Future<void> _autoCompleteNameField() async {
    nameController.text = widget.session.name;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoCompleteNameField();
    });
  }

  void _createUser() {
    final user = UserModel(
      id: widget.session.$id,
      name: nameController.text,
      pix: "",
      phone: widget.session.phone,
      trevos: 0,
      leafs: 0,
    );
    context.read<UserCubit>().create(user);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void _handleCreateUserSuccess(CreateUserSuccess state) {
    Routing(context).home(state.user);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        switch (state) {
          case UserFailure _:
            handleFailure(context, state.failure);
          case CreateUserSuccess _:
            _handleCreateUserSuccess(state);
        }
      },
      builder: (context, state) {
        return LoadingLayer(
          isLoading: state is UserLoading,
          child: Scaffold(
            bottomNavigationBar: const LoginProgress(pages: 3, currentPage: 3),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: ColorConstants.mainGreen,
                    ),
                    child: const SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            width: 150,
                            image: AssetConstants.cloverFullLogoWhite,
                          ),
                          SizedBox(height: 80),
                          TextWelcome(
                            text: "Corra para agarrar seu grande prêmio agora!",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),

                        const TextTitle(text: "Como podemos te chamar?"),
                        const SizedBox(height: 10),
                        const TextSecondary(
                          text:
                              "Esse nome sera visivel para todos dentro da Clover em prol da transparencia. Tambem utilizaremos para te enviar premios.",
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(22),
                            hintText: "Insira seu nome aqui",
                            fillColor: ColorConstants.inputFill,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorConstants.mainGreen,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Button confirm
                        CustomButton(
                          text: "Confirmar",
                          onTap: _createUser,
                          borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
                          color: ColorConstants.mainGreen,
                          icon: FontAwesomeIcons.rocket,
                        ),
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

// LoadingLayer(
//           isLoading: state is SessionLoading,
//           child: Scaffold(
//             bottomNavigationBar: const LoginProgress(pages: 3, currentPage: 1),
//             body: SafeArea(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(25),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 50),
//                       // Clove logo
//                       const Image(
//                         width: 150,
//                         image: AssetConstants.cloverFullLogoGreen,
//                       ),
//                       const SizedBox(height: 30),

//                       // Motivational sentence
//                       const TextWelcome(text: "Corra para agarrar seu GRANDE prêmio agora! \$\$\$"),
//                       const SizedBox(height: 80),

//                       // Instructions
//                       const TextTitle(text: "Quase la, seus dados!"),
//                       const SizedBox(height: 10),
//                       const TextSecondary(
//                         text:
//                             "Apenas informações necessárias para possibilitar o envio de prêmios a você! Quando ganhar, utilizaremos estes dados para realizar o envio do PIX direto na sua conta!",
//                       ),
//                       const SizedBox(height: 20),
//                       TextField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(25),
//                           hintText: "Insira seu nome aqui",
//                           fillColor: ColorConstants.inputFill,
//                           filled: true,
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: ColorConstants.mainGreen,
//                               width: 1.0,
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: ColorConstants.mainGreen,
//                               width: 1.0,
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 10),

//                       // Button confirm
//                       CustomButton(
//                         text: "Confirmar",
//                         onTap: _createUser,
//                         borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
//                         color: ColorConstants.mainWhite,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
