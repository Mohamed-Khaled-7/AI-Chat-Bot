import 'package:aichatbot/core/services/api_client.dart';
import 'package:aichatbot/core/services/gemini_chat_service.dart';
import 'package:aichatbot/feature/chat/models/chat_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ApiClientMock extends Mock implements ApiClient {}

Map<String, dynamic> _successResponseBody() => {
  "candidates": [
    {
      "content": {
        "parts": [
          {
            "text": "hello",
            "thoughtSignature":
                "EsELCr4LARFNMg8psv9ECNcpkssUoxpjcoMDyNeumvgaUV3uQEpxK0P2mKvuvxdsoVP2u50GJdw9PAs+emd0Labc+uJIEMWH+RRh5inVrgIlwu3wLElKr+jEiu3Vm50wSzL9aIwwWIeiUtqiqiWoR7dyEkQkVkprDyeEbuG6JmJMZnRLRcg8s8kjMZGjF6t+L9KYWVppKgkz6149LbRwOS7zNcAGgzjYNdq3jIdd+wshYlHa3DbMR7u+zIC8zv4X4GUptpcjW+tySUaMUupKphrP6t+LPMyEShkS+wh8SiNCKXFm5L0Sv+/ADAzKYUppYVtCr6FG47Dn5fkfapolqhVV1Z21QxGE+ppN5N4FYQt9Hfezx/RRKQbMEuMKjyGnf3G2an8HvWke3MA28+MH6FCkKq8E0RZ1w8sWJLesEXCu3dReG57Jdx5LG1zoEmwnjn7iuDvqAPnDQUjf01bsry2+Sy4i4zHZfGrBP+bSi42IVQTQ8lfRxM74qURVwS+b5vDfFQ7bpG/+gzOFaMSyjCcvDXTvi0T7gvH8ufmdR2fazZUZXIri6worO5GEX+PhjV689T7hRVrvCsXoOzOxEb8kk3OXg7EFUqNLDN2mkX485xpYPekQz1Z97Lm9AJzQCFytyzbTaz3q0gKWqad4VyaT9CVPXp1RIWS6ZMCzGiSZ+h6EiY50KjLRSzNCFwyopgtP0pImJUQ+Yf3Fd2TbB3+C7zoSjTGBbwczZVCbM21kmkd1cRpB0M1vWaUEDzDwyEgM3kev13Ea8k5foI+vZqgPdrRjAa3onaSJJFL70P5Wx4MbpSS0XXBSE5keRv8XOohNHntmxCUft4LBNAhbzcgfoesa8Aoo6pygqyqxNsMtds26idI2Hxg2Y8K9RpRXKgz1MPNhbtLxcYidEUOw4mD+UPvwi3Gh0eQCnKHRmtqxWUia/lQ2fLtJRxrJOdR6gYoWu1X4m0x/p+DWFt6c2Fb9QFqzI1tU1sdMYYML6LypEKVXIleyFcXSaG6B/FIGn/Dqk/6CIGRhufefx71L8Ed3cth5tIGsyTvw+beo4WwehCUfo8IpPZAeTwe+N/wT7v5fL98YIYKn3RYyfDVeXnFgUtkBqSWYTWk1bcghD/DYRp30yyZAwH7N8z7OUHfeDl7X69Glbom7gfl9Lb7NCAJRqBoiOwY02iItU4eYz0upfSd9WtrZfqgldSsFEQZGSiylk2ThDYuMIloHx3q3YD0pyLGPQrBj/+xjGaaDCQt1nLv2FUdYz9sqmlYKp2mZCC0oJEOjoiCHkGvqwjUb4CzKtPkkopMtGshoH7OmtP1AcKJoJ7Tm7IKITxJegjXyOX9IQIPRKEVCgH4LZfLMyZWli7MffLpr7+nbF2KBzs4/GsaxRUsDawI6wpLnAy/Qy4abMM9Bw/53La/ZLaaCJZy40vFWmh8L94RLlcPfdBvFdDzfynl88r3y+sHBUACjYJvLl2PVyQ7FPgCrNNkTNIwXLb4I0rcUMdqKe6Zcp12lKtRoydjpwehA4+rYFWuIhoRXYUzx6N3q/xpceV4hN5bZVsb0TaLVo9ILwEznD/FJuxAL96za0ZcdWXy9pioLeivAXiSHTG6jzIYa+rjwnXO9agjrBP256po6q6hTFyprUiyvc9NMJ8jAN1DAYcHKvwVfL1sZ2LdTCIP/xwFlMg+lWWVSjYgI8G0lpWJ9tELbM5m4zf+GfNycExcLBB2qnX4zWfYe++NxqurSebGjbgRbQGNmdmEsaL1DSrNzBfU/Ae7PzeeZ3Vx4xs1+YuLsT8YVzwzSFXFxfFme1eq5slPn2OZBIlY4832YMilri/Fdt7HuAI6JSyACSXYIkQ3rpmXz6Zr37bWE2EOeifbvkDpmgw6W8Xmajw9zbbGz13gWJfgwbf8WawvqzaJB+6JDmXNkHnvKUnA5x4y9XVhWny37hOKN59L2MxipCv7Ox0IkWuFj",
          },
        ],
        'role': "model",
      },
      "finishReason": "STOP",
      "index": 0,
    },
  ],
  "usageMetadata": {
    "promptTokenCount": 202,
    "candidatesTokenCount": 50,
    "totalTokenCount": 595,
    "promptTokensDetails": [
      {"modality": "TEXT", "tokenCount": 202},
    ],
    "thoughtsTokenCount": 343,
    "serviceTier": "standard",
  },
  "modelVersion": "gemini-3.6-flash",
  "responseId": "WkOMap_YFqWtvdIP0KrCkQU",
};
DioException _getRetryableException() => DioException(
  requestOptions: RequestOptions(
    path: '/v1beta/models/gemini-3.6-flash:generateContent',
  ),
  type: DioExceptionType.badResponse,
  response: Response(
    requestOptions: RequestOptions(
      path: '/v1beta/models/gemini-3.6-flash:generateContent',
    ),
    statusCode: 429,
  ),
);
DioException _getNotRetryableException() => DioException(
  requestOptions: RequestOptions(
    path: '/v1beta/models/gemini-3.6-flash:generateContent',
  ),
  type: DioExceptionType.badResponse,
  response: Response(
    requestOptions: RequestOptions(
      path: '/v1beta/models/gemini-3.6-flash:generateContent',
    ),
    statusCode: 400,
  ),
);

Response<Map<String, dynamic>> _getSuccessRespons() => Response(
  requestOptions: RequestOptions(
    path: '/v1beta/models/gemini-3.6-flash:generateContent',
  ),
  data: _successResponseBody(),
  statusCode: 200,
);
void main() {
  late ApiClientMock apiClientMock;
  late GeminiChatService geminiChatService;
  setUp(() {
    apiClientMock = ApiClientMock();
    geminiChatService = GeminiChatService(
      apiClient: apiClientMock,
      api: 'fake-api-key',
    );
  });
  group("APiClient Retry logic", () {
    test("first attemp , Successed on first attemp", () async {
      when(
        () => apiClientMock.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => _getSuccessRespons().data!);

      var result = await geminiChatService.sendMessage([]);
      var callCount = verify(
        () => apiClientMock.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).callCount;
      expect(callCount, equals(1));
      expect(result, isA<ChatMessageModel>());
    });
    test("second attempt, first fail second success, retryable", () async {
      var count = 0;
      when(
        () => apiClientMock.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async {
        count++;
        if (count == 1) {
          throw _getRetryableException();
        }
        return _getSuccessRespons().data!;
      });
      var result = await geminiChatService.sendMessage([]);
      var callCount = verify(
        () => apiClientMock.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).callCount;
      expect(callCount, equals(2));
      expect(result, isA<ChatMessageModel>());
    });
  });
  test("first attemp fail ,but not retryable", () async {
    when(
      () => apiClientMock.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) async => throw _getNotRetryableException());
    await expectLater(
      () => geminiChatService.sendMessage([]),
      throwsA(isA<DioException>()),
    );
    int count = verify(
      () => apiClientMock.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).callCount;
    expect(count, equals(1));
  });
  test(
    "first attemp fail , second attemp fail ,third attemp succesed",
    () async {
      var count = 0;
      when(
        () => apiClientMock.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async {
        count++;
        if (count == 3) {
          return _getSuccessRespons().data!;
        } else {
          throw _getRetryableException();
        }
      });
      var result = await geminiChatService.sendMessage([]);
      var callCount = verify(
        () => apiClientMock.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).callCount;
      expect(result, isA<ChatMessageModel>());
      expect(callCount, equals(3));
    },
  );
  test("faild on third attempts", () async {
    when(
      () => apiClientMock.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) => throw _getRetryableException());

    await expectLater(()=>geminiChatService.sendMessage([]), throwsA(isA<DioException>()));
    var callCount = verify(
      () => apiClientMock.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).callCount;

    expect(callCount, equals(3));
  });
}
