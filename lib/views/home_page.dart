import 'package:covid19_tracker/bloc/covid_bloc.dart';
import 'package:covid19_tracker/model/covid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CovidBloc _covidBloc = CovidBloc();

  @override
  void initState() {
    _covidBloc.add(FetchCovid());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('COVID-19')),
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
              if (state is CovidInitial) {
                return _buildLoading();
              } else if (state is CovidLoading) {
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

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
