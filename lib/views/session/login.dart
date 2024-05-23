import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:clover/bloc/session.bloc.dart';
import 'package:clover/bloc/user.bloc.dart';
import 'package:clover/common/constants.dart';
import 'package:clover/common/router.dart';
import 'package:clover/common/snackbars.dart';
import 'package:clover/common/typedefs.dart';
import 'package:clover/common/widgets/custom_button.dart';
import 'package:clover/common/widgets/loading_layer.dart';
import 'package:clover/common/widgets/text_title.dart';
import 'package:clover/views/session/widgets/bottom_progress.dart';
import 'package:clover/views/session/widgets/text_divider.dart';
import 'package:clover/views/session/widgets/text_secondary.dart';
import 'package:clover/views/session/widgets/text_welcome.dart';

class AskPhoneNumber extends StatefulWidget {
  const AskPhoneNumber({super.key});

  @override
  State<AskPhoneNumber> createState() => _AskPhoneNumberState();
}

class _AskPhoneNumberState extends State<AskPhoneNumber> {
  late AppwriteSession currentSession;
  var selectedCountry = countries.firstWhere((country) => country.flag == "🇧🇷");
  TextEditingController phoneNumberController = TextEditingController();

  void _handleCreatePhoneSessionSuccess(CreatePhoneSessionSuccess state) {
    Routing(context).askOtpCode(userId: state.userId, phoneNumber: phoneNumberController.text);
  }

  void _handleCreateGoogleSessionSuccess(CreateGoogleSessionSuccess state) {
    context.read<SessionCubit>().get();
  }

  void _handleGetSessionSuccess(GetSessionSuccess state) {
    currentSession = state.session;
    context.read<UserCubit>().findById(state.session.$id);
  }

  void _handleFindUserByIdSuccess(FindUserByIdSuccess state) {
    Routing(context).home(state.user);
  }

  void _handleFindUserByIdFailure(FindUserByIdFailure state) {
    Routing(context).askUserData(session: currentSession);
  }

  void _createPhoneSession() {
    context.read<SessionCubit>().createPhoneSession(phoneNumberController.text, selectedCountry);
  }

  void _createGoogleSession() {
    context.read<SessionCubit>().createGoogleSession();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionCubit, SessionState>(
      listener: (context, state) {
        switch (state) {
          case SessionFailure _:
            showErrorSnackBar(context, state.failure);
          case CreatePhoneSessionSuccess _:
            _handleCreatePhoneSessionSuccess(state);
          case CreateGoogleSessionSuccess _:
            _handleCreateGoogleSessionSuccess(state);
          case GetSessionSuccess _:
            _handleGetSessionSuccess(state);
        }
      },
      builder: (context, sessionState) {
        return BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            switch (state) {
              case UserFailure _:
                showErrorSnackBar(context, state.failure);
              case FindUserByIdSuccess _:
                _handleFindUserByIdSuccess(state);
              case FindUserByIdFailure _:
                _handleFindUserByIdFailure(state);
            }
          },
          builder: (context, userState) {
            return LoadingLayer(
              isLoading: sessionState is SessionLoading || userState is UserLoading,
              child: Scaffold(
                bottomNavigationBar: const LoginProgress(pages: 3, currentPage: 1),
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
                                text: "Voce esta prestes a ganhar grandes premios!",
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

                            // Instructions
                            const TextTitle(text: "Insira seu numero"),
                            const SizedBox(height: 10),
                            const TextSecondary(
                              text:
                                  "Enviaremos um código via SMS para confirmar seu número. Não se preocupe, levará apenas alguns segundos.",
                            ),
                            const SizedBox(height: 20),

                            // User phone input
                            IntlPhoneField(
                              controller: phoneNumberController,
                              onCountryChanged: (country) => selectedCountry = country,
                              flagsButtonPadding: const EdgeInsets.only(left: 10),
                              showDropdownIcon: false,
                              initialCountryCode: 'BR',
                              invalidNumberMessage: 'Numero de telefone invalido',
                              disableLengthCheck: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: "Insira seu numero aqui",
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
                              onTap: _createPhoneSession,
                              icon: FontAwesomeIcons.solidPaperPlane,
                              borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
                              color: ColorConstants.mainGreen,
                            ),
                            const SizedBox(height: 50),
                            const TextDivider(text: "Ou faça login com"),
                            const SizedBox(height: 50),

                            GestureDetector(
                              onTap: _createGoogleSession,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Image(
                                      width: 20,
                                      height: 20,
                                      image: AssetConstants.googleLogo,
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      "Continuar com sua conta Google",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: ColorConstants.mainText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
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
      },
    );
  }
}
