import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/l10n/app_localizations.dart';

import 'package:musicplayer/src/core/theme/app_theme.dart';
import 'package:musicplayer/src/core/theme/app_theme_catalog.dart';
import 'package:musicplayer/src/core/theme/theme_data_factory.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';

import 'package:musicplayer/src/features/main/sections/bottom_panel_section.dart';
import 'package:musicplayer/src/services/player/audio_player_state.dart';
import 'package:musicplayer/src/services/player/player_contracts.dart';

class MockPlayerStateReader extends Mock with ChangeNotifier implements PlayerStateReader {}
class MockPlayerControls extends Mock implements PlayerControls {}

void main() {
  late MockPlayerStateReader playerStateReader;
  late MockPlayerControls playerControls;

  final station = RadioStation(
    id: '1',
    titleKey: 'rockRadio',
    streamUrl: Uri.parse('https://example.com/stream'),
  );

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ListenableProvider<PlayerStateReader>.value(value: playerStateReader),
        Provider<PlayerControls>.value(value: playerControls),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: ThemeDataFactory.fromAppTheme(AppThemes.byType(AppThemeMode.light)),
        home: const Scaffold(
          bottomNavigationBar: BottomPanelSection(),
        ),
      ),
    );
  }

  setUp(() {
    playerStateReader = MockPlayerStateReader();
    playerControls = MockPlayerControls();
    when(() => playerControls.togglePlayPause()).thenAnswer((_) async {});
    when(() => playerControls.nextStation()).thenAnswer((_) async {});
    when(() => playerControls.previousStation()).thenAnswer((_) async {});
  });

  testWidgets('Renders empty panel when no current station', (tester) async {
    when(() => playerStateReader.state).thenReturn(AudioPlayerState.empty);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.play_arrow), findsNothing);
    expect(find.byIcon(Icons.skip_next), findsNothing);
    expect(find.byIcon(Icons.skip_previous), findsNothing);
  });

  testWidgets('Renders controls and forwards button taps to PlayerService', (tester) async {
    when(() => playerStateReader.state).thenReturn(
      AudioPlayerState.empty.copyWith(
        currentStation: station,
        isPlaying: false,
        isLoading: false,
      ),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    expect(find.byIcon(Icons.skip_next), findsOneWidget);
    expect(find.byIcon(Icons.skip_previous), findsOneWidget);

    await tester.tap(find.byIcon(Icons.skip_previous));
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.tap(find.byIcon(Icons.skip_next));
    await tester.pumpAndSettle();

    verify(() => playerControls.previousStation()).called(1);
    verify(() => playerControls.togglePlayPause()).called(1);
    verify(() => playerControls.nextStation()).called(1);
  });

  testWidgets('Shows loader instead of play/pause while loading', (tester) async {
    when(() => playerStateReader.state).thenReturn(
      AudioPlayerState.empty.copyWith(
        currentStation: station,
        isLoading: true,
        isPlaying: false,
      ),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsNothing);
    expect(find.byIcon(Icons.pause), findsNothing);
  });
}
