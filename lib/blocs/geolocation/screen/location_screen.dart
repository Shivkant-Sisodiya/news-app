import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:flutter_news_app/models/article_model.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  List<ArticleModel> articleList = [];

  LocationScreen({Key? key, required this.articleList}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: BlocBuilder<GeolocationBloc, GeolocationState>(
            builder: (context, state) {
              if (state is GeolocationLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GeolocationLoaded) {
                List<Marker> _marker = [];
                List<Marker> _list = [
                  Marker(
                    markerId: MarkerId('1'),
                    position: LatLng(
                        widget.articleList[1].lat, widget.articleList[1].lon),
                    infoWindow: InfoWindow(title: widget.articleList[1].title),
                  ),
                  Marker(
                    markerId: MarkerId('2'),
                    position: LatLng(
                        widget.articleList[2].lat, widget.articleList[2].lon),
                    infoWindow: InfoWindow(title: widget.articleList[2].title),
                  ),
                  Marker(
                    markerId: MarkerId('3'),
                    position: LatLng(
                        widget.articleList[3].lat, widget.articleList[3].lon),
                    infoWindow: InfoWindow(title: widget.articleList[3].title),
                  ),
                  Marker(
                    markerId: MarkerId('4'),
                    position: LatLng(
                        widget.articleList[4].lat, widget.articleList[4].lon),
                    infoWindow: InfoWindow(title: widget.articleList[4].title),
                  ),
                  Marker(
                    markerId: MarkerId('5'),
                    position: LatLng(
                        widget.articleList[5].lat, widget.articleList[5].lon),
                    infoWindow: InfoWindow(title: widget.articleList[5].title),
                  ),
                ];
                _marker.addAll(_list);
                return Stack(
                  children: [
                    GoogleMap(
                      myLocationEnabled: true,
                      markers: Set<Marker>.of(_marker),
                      circles: Set.from([
                        Circle(
                          circleId: CircleId('1'),
                          center: LatLng(state.position.latitude,
                              state.position.longitude),
                          radius: 1000,
                          fillColor: Colors.blue.shade100.withOpacity(0.5),
                          strokeColor: Colors.blue.shade100.withOpacity(0.1),
                        )
                      ]),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            state.position.latitude, state.position.longitude),
                        zoom: 10,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 20,
                      right: 20,
                      child: Text(
                        'lat ' +
                            state.position.latitude.toString() +
                            ' ' +
                            'lon ' +
                            state.position.longitude.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          decorationColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Text('somethingwent wrong');
              }
            },
          ),
        ),
      ],
    );
  }
}
