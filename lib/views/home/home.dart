import 'dart:async';

import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:clover/bloc/prize.bloc.dart';
import 'package:clover/bloc/session.bloc.dart';
import 'package:clover/bloc/user.bloc.dart';
import 'package:clover/common/bloc_handlers.dart';
import 'package:clover/common/constants.dart';
import 'package:clover/common/router.dart';
import 'package:clover/common/typedefs.dart';
import 'package:clover/common/widgets/custom_button.dart';
import 'package:clover/common/widgets/loading_layer.dart';
import 'package:clover/common/widgets/loading_skeleton.dart';
import 'package:clover/common/widgets/text_title.dart';
import 'package:clover/models/user.dart';
import 'package:clover/views/home/widgets/prize_info.dart';
import 'package:clover/views/home/widgets/raffle.dart';
import 'package:clover/views/home/widgets/top_user.dart';
import 'package:clover/views/home/widgets/top_users_modal.dart';
import 'package:clover/views/session/widgets/text_secondary.dart';

import 'widgets/hint.dart';

class Home extends StatefulWidget {
  final UserModel user;

  const Home({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pixController = TextEditingController();

  Timer? _prizeTimer;
  Duration _timeLeft = const Duration();

  void _getTimeLeftToEndOfMonth() {
    final now = DateTime.now();
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 0);
    final duration = endOfMonth.difference(now);

    setState(() => _timeLeft = duration);
  }

  void _startPrizeTimer() {
    final now = DateTime.now();
    final nextMinute = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
    ).add(const Duration(minutes: 1));
    final initialDelay = nextMinute.difference(now);

    Timer(initialDelay, () {
      _getTimeLeftToEndOfMonth();

      _prizeTimer = Timer.periodic(const Duration(minutes: 1), (Timer t) => _getTimeLeftToEndOfMonth());
    });
  }

  void _loadMonthlyPrize() {
    context.read<PrizeCubit>().loadMonthlyPrize();
  }

  void _findTrendingUsers() {
    context.read<UserCubit>().findTrending();
  }

  void _goToBundles() {
    Routing(context).bundles(widget.user);
  }

  void _goToAccount() {
    Routing(context).account(widget.user);
  }

  @override
  void initState() {
    super.initState();
    _getTimeLeftToEndOfMonth();
    _startPrizeTimer();
    _loadMonthlyPrize();
    _findTrendingUsers();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    _prizeTimer?.cancel();
    pixController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    _loadMonthlyPrize();
    _findTrendingUsers();
  }

  @override
  Widget build(BuildContext context) {
    final days = _timeLeft.inDays;
    final hours = _timeLeft.inHours % 24;
    final minutes = _timeLeft.inMinutes % 60;

    return BlocConsumer<SessionCubit, SessionState>(
      listener: (context, state) {
        switch (state.runtimeType) {}
      },
      builder: (context, state) {
        return LoadingLayer(
          isLoading: state is SessionLoading,
          child: Scaffold(
            body: RefreshIndicator(
              color: ColorConstants.mainGreen,
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
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
                            SizedBox(
                              height: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: const [
                                  SizedBox(width: 25),
                                  Raffle(),
                                  SizedBox(width: 10),
                                  Raffle(),
                                  SizedBox(width: 25),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: Column(
                        children: [
                          TextTitle(text: "Conta", icon: FontAwesomeIcons.angleRight, onTap: _goToAccount),
                          const SizedBox(height: 25),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetConstants.cloverOnlyLogoGreen,
                                width: 25,
                              ),
                              const SizedBox(width: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${widget.user.trevos}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Trevos",
                                    style: TextStyle(fontSize: 15, color: ColorConstants.mainGrey),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.leaf,
                                color: ColorConstants.mainGreen,
                              ),
                              const SizedBox(width: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${widget.user.leafs}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Folhas",
                                    style: TextStyle(fontSize: 15, color: ColorConstants.mainGrey),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            text: "Adicionar mais trevos",
                            onTap: _goToBundles,
                            icon: FontAwesomeIcons.bagShopping,
                            borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
                            color: ColorConstants.mainGreen,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          SizedBox(width: 25),
                          Hint(text: "Clique no botao acima e ganhe trevos DE GRAÇA, participe!"),
                          SizedBox(width: 10),
                          Hint(text: "Mantenha seu PIX atualizado, podemos te enviar premios!"),
                          SizedBox(width: 10),
                          Hint(text: "Acumule folhas participando de sorteios e adquirindo trevos!"),
                          SizedBox(width: 10),
                          Hint(text: "Todos os sorteios da Clover sao legalizados pela Loteria Federal!"),
                          SizedBox(width: 10),
                          Hint(text: "Indique um amigo e ganhe 10 Trevos e 100 Folhas"),
                          SizedBox(width: 25),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          TextTitle(
                            text: "Usuarios em alta",
                            icon: FontAwesomeIcons.circleQuestion,
                            onTap: () => showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                ),
                              ),
                              builder: (context) => const TopUsersModal(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const TextSecondary(
                            text:
                                "O primeiro colocado, portando a maior quantidade de folhas, receberá um prêmio ao final do mês. Não perca tempo e acumule folhas para chegar ao pódio!",
                          ),
                          const SizedBox(height: 30),
                          PrizeInfo(
                            icon: FontAwesomeIcons.sackDollar,
                            label: "Premio acumulado",
                            value: BlocConsumer<PrizeCubit, PrizeState>(
                              listener: (context, state) {
                                switch (state) {
                                  case PrizeFailure _:
                                    handleFailure(context, state.failure);
                                }
                              },
                              builder: (context, state) {
                                if (state is LoadPrizeSuccess) {
                                  return Text(
                                    "R\$ ${state.prize.prizeAmount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: ColorConstants.mainGreen,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto",
                                      fontSize: 14,
                                    ),
                                  );
                                }

                                return LoadingAnimationWidget.fourRotatingDots(
                                  color: ColorConstants.mainGreen,
                                  size: 20,
                                );
                              },
                            ),
                            color: ColorConstants.mainGreen,
                          ),
                          const SizedBox(height: 15),
                          PrizeInfo(
                            icon: FontAwesomeIcons.clock,
                            label: "Tempo restante",
                            value: Text(
                              "${days}d ${hours}h ${minutes}m",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 148, 24, 15),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                                fontSize: 14,
                              ),
                            ),
                            color: const Color.fromARGB(255, 148, 24, 15),
                          ),
                          BlocConsumer<UserCubit, UserState>(
                            listener: (context, state) {
                              switch (state) {
                                case UserFailure _:
                                  handleFailure(context, state.failure);
                              }
                            },
                            buildWhen: (previous, current) {
                              switch (current) {
                                case FindTrendingSuccess _:
                                  return true;
                                case FindTrendingLoading _:
                                  return true;
                                case _:
                                  return false;
                              }
                            },
                            builder: (context, state) {
                              if (state is FindTrendingSuccess) {
                                return Column(
                                  children: <Widget>[
                                    const SizedBox(height: 20),
                                    ...List.generate(
                                      state.users.length,
                                      (index) {
                                        return Column(
                                          children: [
                                            TopUser(
                                              name: state.users[index].name,
                                              leafs: state.users[index].leafs,
                                              position: index + 1,
                                            ),
                                            if (index < state.users.length - 1) const SizedBox(height: 5),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }

                              return LoadingSkeleton(
                                amount: 3,
                                skeleton: TopUser.skeleton(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 1),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: TextTitle(text: "Meus sorteios"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: DottedBorder(
                        dashPattern: const [10],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorConstants.secondaryGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.faceFrownOpen,
                              ),
                              SizedBox(width: 20),
                              Text("Nenhum sorteio, clique para participar")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
