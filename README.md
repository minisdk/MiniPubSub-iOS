# MiniPubSub-iOS
iOS와 게임 엔진 간 통신을 위한 pubsub 방식의 라이브러리입니다.
직렬화된 데이터를 발행하여 사전 등록된 구독자들에게 전달합니다.

## 시작하기
[Release](https://github.com/minisdk/MiniPubSub-iOS/releases) 에서 framework를 다운 받아 프로젝트에 임포트합니다.

## 주요 요소들

### Payload
데이터 저장 객체입니다.<br>
데이터를 json 시리얼라이즈 하여 저장합니다.

### Topic
발행 데이터의 타입입니다.<br>
어느 플랫폼(Game or Native) 의 어느 구독자에게 전달할지 결정합니다.

### MessageInfo
발행 데이터의 메타데이터입니다.<br>
해당 발행 데이터의 발행자, 목적지 정보(`Topic`) 같은 데이터 전달에 필요한 정보를 담고 있습니다.

### Message
`Payload`와 `MessageInfo` 객체를 포함한 데이터 전달 객체입니다.<br>
발행 데이터의 
- `key` : 발행자와 구독자 사이에 약속한 발행 데이터 식별자입니다.<br>
발행자가 특정 키로 `Topic`을 생성해서 메세지를 발행하면, 사전에 해당 키를 구독한 구독자가 메세지를 받습니다.
- `data<T>` : 역직렬화된 객체를 반환합니다.

### Messenger
`Message` 객체를 발행(`publish`) 하거나 구독(`subscribe`)합니다.<br>
또한 동기적으로 `Message` 객체를 보내고(`sendSync`) 처리(`handle`) 하여 반환합니다.<br><br>
데이터는 크게 세가지 방법으로 주고 받을 수 있습니다.
- pub/sub
  - 기본적인 발행/구독 방식. 구독자가 `subscribe` 하고 발행자가 `publish` 하여 `Message`를 주고 받습니다. 
- pub/sub and reply
  - 구독자가 다시 발행자에게 `Message`를 비동기적으로 전달(`reply`)합니다.
- sendSync/handle
  - 발행자가 동기적으로 `Message`를 전달(`sendSync`)하고 사전에 처리(`handle`) 하기로 한 구독자가 그 결과(`Payload`) 를 반환합니다.
 
## 예제 코드
```swift
class MyController{
    private let KEY_SUB_HELLO = "SAMPLE::HELLO"
    private let KEY_PUB_WORLD = "SAMPLE::WORLD"
    private let KEY_SUB_HELLO_REPLY_MODE = "SAMPLE::HELLO_REPLY"
    private let KEY_SYNC_SEND = "SAMPLE::SYNCSEND"
    private let messenger = Messenger()

    public init {
        messenger.subscribe(key: KEY_SUB_HELLO, delegate: onHello)
        messenger.subscribe(KEY_SUB_HELLO_REPLY_MODE, delegate: onHelloReplyMode)
        messenger.handle(KEY_SYNC_SEND, delegate: onSyncSend)
    }

    private func onHello(message: Message){
        guard let myData: MyHelloData = message.data() else {
            return
        }
        // Do Something...
        messenger.publish(
            topic: Topic(key: KEY_PUB_WORLD, target: SdkType.Game),
            payload: Payload(data: MyWorldData(/* initialize data members */))
        )
    }

    private func onHelloReplyMode(message: Message){
        guard let myData: MyHeloData = message.data() else {
            return
        }
        // Do Something...
        messenger.reply(
            received: message.info,
            payload: Payload(data: MyWorldData(/* initialize data members */))
        )
    }

    private func onSyncSend(message: Message)-> Payload{
        guard let mySyncData: MySyncData = message.data() else {
            return Payload(data: MyErrorData())
        }
        // Do Something...
        return Payload(data: MySyncResult(/* initialize data members */)
    }
}
```
