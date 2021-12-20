import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({
    required this.onPopUp,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  final void Function()? onPopUp;
  final void Function(String cityName) onSearch;

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> with TickerProviderStateMixin {
  // Pretty

  late final AnimationController _elevationController;
  late final AnimationController _alphaController;
  double _elevation = 0.0;
  double _alpha = 0.0;
  String _inputCity = '';

  @override
  void initState() {
    super.initState();

    _elevationController = AnimationController(
      vsync: this,
      value: 0,
      lowerBound: 0,
      upperBound: 15,
      duration: const Duration(milliseconds: 500),
    )..animateTo(15, curve: Curves.easeOutExpo);

    _alphaController = AnimationController(
      vsync: this,
      value: 0,
      lowerBound: 0,
      upperBound: 150,
      duration: const Duration(milliseconds: 500),
    )..animateTo(150, curve: Curves.easeOutExpo);

    _elevationController.addListener(changeElevation);
    // _elevationController.forward();

    _alphaController.addListener(changeAplha);
    // _alphaController.forward();
  }

  void changeElevation() {
    setState(() {
      _elevation = _elevationController.value;
    });
  }

  void changeAplha() {
    setState(() {
      _alpha = _alphaController.value;
    });
  }

  @override
  void dispose() {
    _elevationController.removeListener(changeElevation);
    _elevationController.dispose();

    _alphaController.removeListener(changeAplha);
    _alphaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onPopUp,
            child: Container(
              color: Color.fromARGB(_alpha.toInt(), 0, 0, 0),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 65,
          child: SizedBox(
            height: 70,
            child: Card(
              elevation: _elevation,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter city name",
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _inputCity = newValue;
                        });
                      },
                      onSubmitted: (cityName) => widget.onSearch(_inputCity),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 5,
                    child: TextButton(
                      onPressed: () => widget.onSearch(_inputCity),
                      child: const Icon(
                        Icons.search_rounded,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
