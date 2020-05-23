import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'model/product.dart';
import 'login.dart';

const double _kFlingVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;
  final Category category;

  const Backdrop(
      {@required this.frontLayer,
      @required this.backLayer,
      @required this.frontTitle,
      @required this.backTitle,
      @required this.category})
      : assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null),
        assert(category != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backDropKey = GlobalKey(debugLabel: 'backDrop');
  AnimationController _animationController;

  Widget _buildStackWidget(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_animationController.view);

    return Stack(key: _backDropKey, children: <Widget>[
      ExcludeSemantics(
        excluding: _frontLayerVisible,
        child: widget.backLayer,
      ),
      PositionedTransition(
        rect: layerAnimation,
        child: _Frontlayer(
          child: widget.frontLayer,
          onCategoryTap: _toggleBackdropLayerVisibility,
        ),
      )
    ]);
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _animationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _animationController.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300), value: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void didUpdateWidget(Backdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.category != oldWidget.category) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _animationController.fling(velocity: _kFlingVelocity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      title: _BackdropTitle(
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
        onTap: _toggleBackdropLayerVisibility,
        listenable: _animationController.view,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            ),
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            semanticLabel: 'tune',
          ),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            ),
        ),
      ],
    );
    return Scaffold(
        appBar: appBar,
        body: LayoutBuilder(
          builder: _buildStackWidget,
        ));
  }
}

class _Frontlayer extends StatelessWidget {
  const _Frontlayer({
    Key key,
    this.child,
    this.onCategoryTap,
  });

  final VoidCallback onCategoryTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(46.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onCategoryTap,
            child: Container(
              height: 40.0,
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final Widget frontTitle;
  final Widget backTitle;
  final Function onTap;

  const _BackdropTitle({
    @required this.frontTitle,
    @required this.backTitle,
    Key key,
    this.onTap,
    Listenable listenable,
  })  : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.headline6,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 72.0,
            child: IconButton(
              onPressed: onTap,
              icon: Stack(
                children: <Widget>[
                  Opacity(
                    opacity: animation.value,
                    child: ImageIcon(
                      AssetImage('assets/slanted_menu.png'),
                    ),
                  ),
                  FractionalTranslation(
                    translation: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(1.0, 0.0),
                    ).evaluate(animation),
                    child: ImageIcon(
                      AssetImage('assets/diamond.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Opacity(
                opacity: CurvedAnimation(
                  parent: ReverseAnimation(animation),
                  curve: Interval(0.5, 1.0),
                ).value,
                child: FractionalTranslation(
                  translation: Tween<Offset>(
                    begin: Offset.zero,
                    end: Offset(0.5, 0.0),
                  ).evaluate(animation),
                  child: backTitle,
                ),
              ),
              Opacity(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.5, 1.0),
                ).value,
                child: FractionalTranslation(
                  translation: Tween<Offset>(
                    begin: Offset(-0.25, 0.0),
                    end: Offset.zero,
                  ).evaluate(animation),
                  child: frontTitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
