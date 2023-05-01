import 'package:covid19_tracker/bloc/covid_bloc/covid_bloc.dart';
import 'package:covid19_tracker/bloc/language_bloc/language_bloc.dart';
import 'package:covid19_tracker/model/covid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final languageBloc = LanguageBloc();
  final CovidBloc _covidBloc = CovidBloc();
  var selectedLanguage = 'English';
  @override
  void initState() {
    _covidBloc.add(FetchCovid());
    languageBloc.add(const ChangeLanguageToEn());
    super.initState();
  }

  @override
  void dispose() {
    _covidBloc.close();
    languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Covid-19 Tracker',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          BlocProvider(
            create: (context) => LanguageBloc(),
            child: BlocListener<LanguageBloc, LanguageState>(
              listener: (context, state) {
                if (state is LanguageChanged) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Language changed to ${state.locale}'),
                    ),
                  );
                }
              },
              child: BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return TextButton.icon(
                      onPressed: () {
                        debugPrint(state.toString());
                        if (state is LanguageInitial) {
                          debugPrint(state.locale.languageCode.toString());
                          if (state.locale.languageCode == 'en') {
                            languageBloc.add(const ChangeLanguageToVi());
                          } else {
                            languageBloc.add(const ChangeLanguageToEn());
                          }
                        }
                        // languageBloc
                        //     .add(const ChangeLanguage(Locale('vi', 'VN')));
                      },
                      icon: const Icon(
                        Icons.language,
                        color: Colors.black,
                      ),
                      label: Text(
                        state is LanguageChanged
                            ? state.locale.languageCode == 'en'
                                ? 'Tiếng Việt'
                                : 'English'
                            : 'English',
                        style: const TextStyle(color: Colors.black),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _covidBloc,
        child: BlocListener<CovidBloc, CovidState>(
          listener: (context, state) {
            if (state is CovidError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  // content: Text('wtf is this'),
                ),
              );
            }
          },
          child: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state is CovidInitial || state is CovidLoading) {
                return _buildLoading();
              } else if (state is CovidLoaded) {
                return _buildCard(context, state.covidModel);
              } else if (state is CovidError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CovidModel model) {
    return ListView.builder(
      itemCount: model.countries!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 196, 193, 193), width: 0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Country: ${model.countries![index].country}".toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "Total Confirmed: ${model.countries![index].totalConfirmed}"
                    .toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "Total Deaths: ${model.countries![index].totalDeaths}"
                    .toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "Total Recovered: ${model.countries![index].totalRecovered}"
                    .toUpperCase(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(
      child: RiveAnimation.network(
          'https://public.rive.app/community/runtime-files/113-173-loading-book.riv',
          fit: BoxFit.scaleDown));
}
