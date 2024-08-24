// Import the test package
import 'package:test/test.dart';
import 'package:tictactoe/repository/game_repository.dart';
import 'package:tictactoe/utils/domain_utils.dart';

void main() {
  late GameRepository gameRepository;
  setUp(() {
    gameRepository = GameRepository(initilized: true);
  });
  setUpAll(() {});

  group("Game testing", () {});
  test('Testing winning logic', () {
    //for "O" player type
    gameRepository.ticTacToeData = ["O", "O", "O", "", "", "", "", "", ""];
    expect(Game.checkWinner(gameRepository: gameRepository, playerType: "O"),
        true);

    gameRepository.ticTacToeData = ["", "", "", "O", "O", "O", "", "", ""];
    expect(Game.checkWinner(gameRepository: gameRepository, playerType: "O"),
        true);

    gameRepository.ticTacToeData = ["", "", "", "", "", "", "O", "O", "O"];
    expect(Game.checkWinner(gameRepository: gameRepository, playerType: "O"),
        true);

    //for "X" player type
    gameRepository.ticTacToeData = ["X", "X", "X", "", "", "", "", "", ""];
    expect(Game.checkWinner(gameRepository: gameRepository, playerType: "X"),
        true);

    gameRepository.ticTacToeData = ["", "", "", "X", "X", "X", "", "", ""];
    expect(Game.checkWinner(gameRepository: gameRepository, playerType: "X"),
        true);

    gameRepository.ticTacToeData = ["", "", "", "", "", "", "X", "X", "X"];
    expect(Game.checkWinner(gameRepository: gameRepository, playerType: "X"),
        true);
  });

  test("Game repository testing", () {
    expect(gameRepository.filledBoxes, 0);
    expect(gameRepository.initilized, true);
    expect(gameRepository.isAddPointsListenerCalled, false);
    expect(gameRepository.isDefeatListenerCalled, false);
    expect(gameRepository.isGameDrawListenerCalled, false);
    expect(gameRepository.isLeaveRoomListenerCalled, false);
    expect(gameRepository.isMatchDrawListenerCalled, false);
    expect(gameRepository.isNewPlayerJoinedListenerCalled, false);
    expect(gameRepository.isNoPointsListenerCalled, false);
    expect(gameRepository.isTapListenerCalled, false);
    expect(gameRepository.isWinnerListenerCalled, false);
    expect(gameRepository.iscreateRoomSuccessListenerCalled, false);
    expect(gameRepository.isjoinRoomListenerCalled, false);
    expect(gameRepository.ticTacToeData, ["", "", "", "", "", "", "", "", ""]);
  
  });

  tearDown(() {
    
  });
  tearDownAll(() {});
}
