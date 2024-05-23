import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:clover/bloc/session.bloc.dart';
import 'package:clover/bloc/user.bloc.dart';
import 'package:clover/common/bloc_handlers.dart';
import 'package:clover/common/constants.dart';
import 'package:clover/common/snackbars.dart';
import 'package:clover/common/widgets/custom_button.dart';
import 'package:clover/common/widgets/loading_layer.dart';
import 'package:clover/common/widgets/text_title.dart';
import 'package:clover/models/user.dart';
import 'package:clover/views/session/widgets/text_secondary.dart';

class Account extends StatefulWidget {
  final UserModel user;

  const Account({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController nameController = TextEditingController();
  TextEditingController pixController = TextEditingController();

  Future<void> _autoCompleteNameField() async {
    nameController.text = widget.user.name;
    pixController.text = widget.user.pix;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoCompleteNameField();
    });
  }

  void _updateAccount() {
    final newUser = widget.user.copyWith(name: nameController.text, pix: pixController.text);
    context.read<UserCubit>().update(newUser);
  }

  void _handleUpdateSuccess(BuildContext context, state) {
    Navigator.pop(context);
    showSuccessSnackBar(context, "Conta atualizada com sucesso!");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        switch (state) {
          case UserFailure _:
            handleFailure(context, state.failure);
          case UpdateSuccess _:
            _handleUpdateSuccess(context, state);
        }
      },
      builder: (context, state) {
        return LoadingLayer(
          isLoading: state is UserLoading,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const TextTitle(text: "Atualizar dados"),
                            const SizedBox(height: 20),
                            const TextSecondary(
                              text: "Mantenha seu PIX sempre atualizado para que possamos te enviar premios.",
                            ),
                            const SizedBox(height: 40),
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
                            TextField(
                              controller: pixController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(22),
                                hintText: "Insira seu PIX aqui",
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
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        CustomButton(
                          text: "Atualizar",
                          onTap: _updateAccount,
                          borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
                          color: ColorConstants.mainGreen,
                          icon: FontAwesomeIcons.bookmark,
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
  }
}
