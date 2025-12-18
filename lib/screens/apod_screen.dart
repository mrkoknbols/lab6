import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../cubit/apod_cubit.dart';
import '../cubit/apod_state.dart';

class APODScreen extends StatefulWidget {
  const APODScreen({Key? key}) : super(key: key);

  @override
  State<APODScreen> createState() => _APODScreenState();
}

class _APODScreenState extends State<APODScreen> {
  late APODCubit _apodCubit;

  @override
  void initState() {
    super.initState();
    _apodCubit = APODCubit();
    _apodCubit.fetchAPOD();
  }

  @override
  void dispose() {
    _apodCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NASA APOD'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: BlocProvider.value(
        value: _apodCubit,
        child: BlocBuilder<APODCubit, APODState>(
          builder: (context, state) {
            if (state is APODLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is APODError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ошибка: ${state.message}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _apodCubit.fetchAPOD(),
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              );
            } else if (state is APODLoaded) {
              final apod = state.apod;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (apod.mediaType == 'image')
                      CachedNetworkImage(
                        imageUrl: apod.url,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,
                      )
                    else
                      Container(
                        height: 300,
                        color: Colors.black,
                        child: const Center(
                          child: Text(
                            'Это видео. Перейдите по ссылке для просмотра.',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apod.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (apod.copyright != null)
                            Text(
                              'Автор: ${apod.copyright}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          const SizedBox(height: 10),
                          Text(
                            apod.date,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            apod.explanation,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1995, 6, 16),
            lastDate: DateTime.now(),
          ).then((date) {
            if (date != null) {
              final formattedDate =
                  '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
              _apodCubit.fetchAPOD(date: formattedDate);
            }
          });
        },
        child: const Icon(Icons.calendar_today),
      ),
    );
  }
}