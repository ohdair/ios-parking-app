# ios-parking-app

|Title|Description|
|---|---|
한 줄 소개|위치 기반의 주차장 탐색 서비스
프로젝트 진행기간|23. 05. 17 ~ 23. 05. 31
기술 스택|iOS, UIKit, 네이버 지도 SDK, Firebase

## 📱 구현 화면
|로딩 화면|현재 위치 선택|주차장 선택|즐겨찾기|
|---|---|---|---|
|![Simulator Screen Recording - iPhone 14 Pro - 2023-07-04 at 08 59 38](https://github.com/ohdair/ios-parking-app/assets/79438622/5fb40b7c-fe37-411b-9aa2-3c1b50c5b19a)|![Simulator Screen Recording - iPhone 14 Pro - 2023-07-04 at 08 55 35](https://github.com/ohdair/ios-parking-app/assets/79438622/99644851-aec9-42fc-b1da-dc6f821f936d)|![Simulator Screen Recording - iPhone 14 Pro - 2023-07-04 at 08 56 38](https://github.com/ohdair/ios-parking-app/assets/79438622/43934005-c8ba-4e9f-9579-31e903bdc4ff)|![Simulator Screen Recording - iPhone 14 Pro - 2023-07-04 at 08 57 56](https://github.com/ohdair/ios-parking-app/assets/79438622/bdf401e9-5971-4b94-adec-04c9b2e933d0)|

## 로직
### 프로젝트 <중간 서버 역할>
<img src="https://user-images.githubusercontent.com/79438622/244266349-6ccdc51c-fee3-4338-8445-2ede71b64c7f.png">

### 프로젝트 <서비스 앱>
<img src="https://user-images.githubusercontent.com/79438622/244266364-00d98bb9-85c0-4c07-85a6-126bc62ac859.png">

## ParkingServer 구축
[깃허브 링크](https://github.com/ohdair/ParkingServer)

- 공공데이터 다운로드 받아서 Decode
- Firebase에 저장된 데이터를 확인
- 두 개의 데이터의 갯수로 비교하여 Firebase에 데이터 업데이트

## 📚 Step 설명
### [ Step 1 ]
[주차장 공공데이터 API](https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15012896) 신청

- Postman을 사용하여 API를 사용
- API 데이터에 대한 이해 및 프로젝트 설계

### [ Step 2 ]
[공공데이터 개발 표준](https://www.mois.go.kr/frt/bbs/type001/commonSelectBoardArticle.do?bbsId=BBSMSTR_000000000016&nttId=46683)을 통한 데이터 확인
- 지번 주소와 도로명 주소가 필수라고 나와있지만, 데이터에서는 둘 중 하나만 있는 경우가 존재
- 지도에 표기하기 위한 위/경도가 선택이어서 기존 주소를 가지고 위/경도를 알아내야 하는 상황
- `API로 1번에 100개의 데이터만 수신 가능`, `모든 데이터는 약 15,000개`인 상황
- 전국주차장정보표준데이터를 활용하도록 변경

### [ Step 3 ]
공공 데이터가 업데이트 되거나 앱을 처음 킬 때만 API 호출하도록 **CoreData 채택**
- 공공 데이터를 앱을 킬 때마다 받기에는 사용자 경헙에서는 로딩 화면이 길어진다고 판단
- CoreData로 채택하여 데이터를 저장
- 즐겨찾기 기능 또한 CoreData를 활용

### [ Step 4 ]
사용자 편의를 위해 중간 서버 **Firebase 채택**
- 위/경도가 없는 데이터를 Naver GeoCoding API로 호출
- 비동기로 시간 내 너무 많은 요청으로 Timeout 에러 발생
- async/await 으로 순차적으로 요청하도록 변경, 2700번 이상의 API 호출로 6분 소요
- 데이터 가공되는 코드를 새로운 프로젝트로 이동 후, Firebase에 업로드

## 📓 학습내용 요점

1. API 호출을 최소화도록 하여 사용자 입장에서 로딩화면이 길지 않도록 변경

   서비스 앱에서 모든 것을 해결하기보다는 서버 개발자가 데이터를 가공해서 주는 역할을 만들어서 해결

   API의 호출을 줄이기 위해서는 중간 서버가 큰 역할을 했지만, CoreData를 저장해서 사용할 수 있도록 변경

2. 설계의 중요성 사실 2주의 시간이라고 했지만, 코드로 구현하는 것보다는 데이터 처리에 대한 고민을 많이 하였고,

   로직을 구상하고 마지막 단계로 변경하기 까지는 일주일 간의 테스트 및 확인을 계속해서 구현

   중간 중간 삽질하여서 시간이 흐를 수 있었지만, 설계를 토대로 구현하면서 안될 거 같은 일에 대한 삽질을 하지 않아 일정산출이 편리

## 🚀 트러블 슈팅

### 🚨 HTTP의 통신은 보안상 차단
`App Transport Security has blocked a cleartext HTTP connection toapi.data.go.krsince it is insecure. Use HTTPS instead or add this domain to Exception Domains in your Info.plist.` 및 `Cannot start load of Task <29C551A3-2071-4BA0-852A-9C653A3D0EE5>.<1> since it does not conform to ATS policy` 공공데이터를 받기 위한 URL의 Scheme이 HTTP이기에 연결을 앱 보안상 차단되어 데이터를 받을 수 없는 문제 발생

<img src="https://user-images.githubusercontent.com/79438622/239783504-805a32d5-cb35-4a0a-942d-303d51f19c06.png">

Allow Arbitrary Loads를 YES로 변경하여 데이터를 수신할 수 있도록 변경

### 🚨 URL로 변환 과정에서 Encoding된 문자를 Encoding
URLComponents로 만들어진 문자열을 URL로 변환과정에서 이미 Encoding이 된 API KEY를 또다시 Encoding이 되면서 달라진 URL로 통신이 안되는 문제가 발생

<img width="20%" src="https://user-images.githubusercontent.com/79438622/239785413-26475585-a0dc-4b5c-8b48-4682afd12011.png">
%2BjVASg%3D%3D -> %25BjVASg%253D%253D

그렇기 때문에 Encoding을 제거하여서 키를 [removingpercentencoding](https://developer.apple.com/documentation/foundation/nsstring/1409569-removingpercentencoding)을 사용하여 인코딩을 제거, [rfc3986](https://www.ietf.org/rfc/rfc3986.txt)에서 예약된 문자로 `=`은 변경이 되지만, `+`의경우에는 문자의 조합에서도 사용되어 변환이 되지 않은 거 같아 URLComponents의 `percentEncodedQuery에서 percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")`해주는 방법으로 API를 받게 되었습니다

더욱 범용성있는 코드를 만들기 위에서는 강제로 변환하는 것은 좋지 않다고 생각하나 예외의 상황이라 판단하여 강제 변환을 했습니다

### 🚨 너무 많은 API 요청으로 인한 Timeout
<img width=300 src="https://user-images.githubusercontent.com/79438622/243947141-d131a204-4d32-472b-a0ee-083d762e4789.png">

오류가 없이 정확하도록  `async / await` 을 이용한 순차적으로 API 호출

```Swift
// ParkingServer
// ParkingPlace.swift
extension ParkingPlace {
    func interpolate() async {
        guard self.latitude.isZero,
              self.longitude.isZero else {
            return
        }

        let address = jibunAddress.isEmpty ? roadAddress : jibunAddress
        let endpoint = NaverGeocodingAPI(from: address)

        do {
            let request = try endpoint.urlRequest
            if let data = try await NetworkRouter().fetchItem(with: request, model: NaverGeocodingDTO.self) {
                let coordinate = data.convert()
                self.latitude = coordinate.latitude
                self.longitude = coordinate.longitude
            }
        } catch {
            print(error)
        }
    }
}

// ViewController.swift
    // ...
    for parkingPlace in parkingPlaces {
        await parkingPlace.interpolate()
        currentProgress += 1
        print(String(format: "%.2f", currentProgress / totalProgress * 100) + "%..")

        let jsonData = try JSONEncoder().encode(parkingPlace)
        let uploadData = String(data: jsonData, encoding: .utf8)!
        realDATA.append(uploadData)
    }
    // ...
```
