//
//  BaseballGameView.swift
//  BaseballProject
//
//  Created by Bran on 10/24/25.
//

import SwiftUI

struct BaseballGameRecord: Identifiable {
  let id = UUID()
  let guess: String
  let result: String /// ex) "1S 2B"
}


struct BaseballGameView: View {
  // MARK: - State Properties
  @State private var secretNumber: [Int] = [] /// 중복되지 않는 (0 ~9) 세 자리 숫자
  @State private var records: [BaseballGameRecord] = [] /// 유저가 시도한 게임 결과 기록(List)
  @State private var userInput: String = ""

  @State private var showAlert: Bool = false
  @State private var alertMessage: String = ""

  // MARK: - Initialization
  init() {
    _secretNumber = State(initialValue: generateSecretNumber())
  }

  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        Text("숫자 야구 게임")
          .font(.system(size: 32, weight: .bold))
          .padding(.top, 20)
          .padding(.bottom, 10)

        List {
          ForEach(records) { record in
            HStack {
              Text("입력: \(record.guess)")
                .fontWeight(.medium)
              Spacer()
              Text("결과: \(record.result)")
                .foregroundColor(record.result == "3S 0B" ? .green : .blue)
                .fontWeight(.bold)
            }
          }
        }
        .listStyle(.plain)
        .background(Color(.systemGray6))

        VStack {
          Text("시도 횟수: \(records.count)회")
            .font(.headline)
            .padding(.vertical, 8)
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray5))

        HStack {
          TextField("3자리 숫자 입력", text: $userInput)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
            .frame(maxWidth: .infinity)

          Button("확인") {
            checkGuess()
          }
          .buttonStyle(.borderedProminent)
          .disabled(userInput.count != 3)
        }
        .padding()
      }
      .navigationTitle("Baseball Game")
      .navigationBarHidden(true)
      .onAppear {
        print("정답 숫자: \(secretNumber)")
      }
    }
    .alert(isPresented: $showAlert) {
      Alert(
        title: Text(alertMessage == "3 스트라이크! 정답입니다! 🎉" ? "게임 승리" : "입력 오류"),
        message: Text(alertMessage),
        dismissButton: .default(Text(alertMessage == "3 스트라이크! 정답입니다! 🎉" ? "새 게임 시작" : "확인"), action: {
          if alertMessage.contains("3 스트라이크") {
            startNewGame()
          }
        })
      )
    }
  }
}

// MARK: - Methods (로직 함수)
extension BaseballGameView {
  /// 중복되지 않는 숫자 3개를 선택해 [Int] 배열로 구성해주는 메서드
  /// - Returns: 중복되지 않는 숫자로 구성된 숫자배열 []
  private func generateSecretNumber() -> [Int] {
    [1, 3, 0]
  }

  /// 새 게임 시작
  private func startNewGame() {
    secretNumber = generateSecretNumber()
    records = []
    userInput = ""
    print("새로운 정답: \(secretNumber)")
  }

  /// 사용자 입력 유효성 검사
  /// - 중복되지 않는 3자리 숫자 값이 입력되었는지 확인하는 로직을 작성해주세요.
  /// - Parameter input: 유저가 텍스트필드에 입력한 String 값
  /// - Returns: (isValid: 유저가 입력한 값이 3자리 숫자값인지?, message: 유효하지 않은 값일 경우 보여질 메시지)
  private func validateInput(_ input: String) -> (isValid: Bool, message: String) {
    return (true, "")
  }

  /// 입력값 확인 및 판정 로직
  /// - 1) 유저가 입력한 값이 유효한 값인지 확인 (중복되지 않는 세자리 숫자값)
  /// - 2) 유효한 숫자를 입력한 경우, secretNumber와 비교해 유저가 입력한 값의 게임 결과를 판별해주세요
  ///   - 2 -1 ) 유저가 입력한 숫자가 3S 인 경우, "3 스트라이크! 정답입니다! 🎉" 라는 얼럿 메시지를 보여주세요
  ///   - 2 -2 ) 유저가 입력한 숫자가 3S가 아닌 경우,  records에 게임의 결과값을 추가해주세요. (ex) 246 "1S 1B")
  private func checkGuess() {
    let validation = validateInput(userInput)

    guard validation.isValid else {
      alertMessage = validation.message
      showAlert = true
      return
    }

    var strikes = 0
    var balls = 0

    let resultString = "\(strikes)S \(balls)B"
    let newRecord = BaseballGameRecord(guess: userInput, result: resultString)
    records.insert(newRecord, at: 0)


    userInput = ""
    if strikes == 3 {
      alertMessage = "3 스트라이크! 정답입니다! 🎉"
      showAlert = true
    }
  }
}
