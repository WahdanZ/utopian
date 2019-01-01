import 'package:flutter/widgets.dart';
import 'package:utopian/blocs/contribution_bloc.dart';

class ContributionProvider extends InheritedWidget {
  final ContributionBloc _contributionBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ContributionBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ContributionProvider)
            as ContributionProvider)
        ._contributionBloc;
  }

  ContributionProvider(
      {Key key, ContributionBloc contributionBloc, Widget child})
      : this._contributionBloc = contributionBloc,
        super(key: key, child: child);
}
