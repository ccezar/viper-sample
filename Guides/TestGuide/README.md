# Test Guide

## Índice

- [Intrudução](#introdução)
- [Stack](#stack)
- [Melhores práticas](#melhores-práticas)
   - [Evite usar force unwrapping](#evite-o-uso-de-force-unwrapping)
- [Naming e estrutura de testes](#naming-e-estrutura-de-testes)
- [Dublês de teste](#dublês-de-teste)
    - [Nomeando dublês de teste](#nomeando-dublês-de-teste)
    - [Propriedades do Spy](#propriedades-do-spy)


## Introdução

A prática de automatizar testes é muito importante para softwares. É inaceitável deixar para o cliente final testar nossas features em produção, então devemos garantir que tudo está funcionando como esperado antes de mergear a feature na **main**.

Este é o guideline que devemos seguir ao desenvolver algo nesse repositório:

- Ao desenvolver uma feature, devemos escrever **testes unitários claros** que não deixam dúvidas que a funcionalidade a ser testada funciona como esperado.
- Se você está desenvolvendo uma correção de bug, escreva **testes unitários** para prevenir que esse bug não volte em uma feature futura. Isso é chamado **teste de regressão**.
- Você pode adicionar **testes de snapshot** para garantir que a UI da sua feature está correta. É importante frisar que testes de snapshot são **complementares** aos
testes unitários, ter uma view com teste de snapshot não garante necessariamente que ela funciona. Devemos sempre escrever testes unitários primeiro e usar testes de snapshot para garantir a UI. 

---

## Stack


Devemos usar exclusivamente as bibliotecas abaixo para escrever testes:

- Testes Unitários: **XCTest**
- Testes de Snapshot: **SnapshotTesting**

--- 

## Melhores práticas

- Cada teste individual (test case) deve ser **rápido**. Evite o uso de `sleeps` e `dispatches` que esperam algo acontecer. Você deve mockar os componentes da sua feature para garantir o retorno rápido.
- Você não deve ter **chamadas de network** nos seus testes unitários. Se precisar ter, não é um teste unitário. Mocke seus componentes ao invés de ter instâncias hard-coded.
- Seus testes não devem depender de coisas fora do seu controle, como timezones e localizações fixas. 
- Evite testar múltiplas coisas em um único test case. Cada componente deve ter seu próprio teste.
- Seja descritivo - o nome do teste e o conteúdo devem descrever o que está sendo testado. Comentários só devem ser usados para melhorar o entendimento.

---
### Evite o uso de force unwrapping

Um teste que crasha não irá apenas dificultar o entendimento do motivo da a falha, mas irá também evitar que os outros testes da suite rodem. Isso pode ocultar a visualização da existência de outros problemas que apareceriam se todos os testes fossem executados normalmente, diminuindo assim sua produtividade. Algumas alterativas são:

- Compare usando opcionais
```swift
XCTAssertEqual(try? sut.getBuildNumber(), "123")
```

-  Guard let com XCTFail

```swift
guard let value = value else {
    return XCTFail("Unexpected value nil")
}
```

---

### Naming e estrutura de testes

Para estruturar os testes nós utilizamos:
- AAA (Arrange Act e Assert) ou
- GWT (Given, When, Then)

Por exemplo:

```swift
func test_requestContent_shouldFetchContent() {
    // Arrange
    let userId = "123"

    // Act
    sut.requestContent(with: userId)

    // Assert
    XCTAssertTrue(interactorSpy.fetchContentCalled)
    XCTAssertEqual(interactor.userIdPassed, userId)
}
```

\* Os comentários são para efeitos didáticos, na prática uma quebra de linha já é suficiente para separar as etápas.

---

## Dublês de teste

Dublês de teste (test doubles) são usados para ajudar a isolar o subject under test (sut) e evitar qualquer efeito colateral.

Exitem 5 tipos de dublês:

- **Dummy**: Objetos para preencher as dependencias e configurar cenários. Não são usados para fazer asserts.
- **Fake**: Objetos com implementações funcionais, mas geralmente de forma mais enxuta ou com lógica reduzida. 
- **Stubs**: Objetos que respondem chamadas com valores pre configurados conformando assim com o cenário do caso de teste.
- **Spy**: Objetos usados para gravar informações sobre como está sendo utilizado/ chamados.
- **Mocks**: Objetos pre configurados com com expectativas sobre como deverão ser consumidos e encapsulam a verificação.

Fonte: https://martinfowler.com/bliki/TestDouble.html

### Nomeando dublês de teste

- Class naming: Protocol + tipo do dublê:

```swift
    final class HomePresenterInputProtocolSpy: HomePresenterInputProtocol {} 
```

#### Propriedades do Spy

- Se for um método: Name+Called
- Se for um parametro: Name+Passed
- Se for uma propriedade computada: Name+Accessed
- Se for propriedade para ser retornada: Name+ToBeReturned
- Se o méotodo e a quantidade de chamadas é relevante: Name+Count
- Todas propriedades devem ser `private(set) var` para aumentar a confiabilidade do teste, garantindo que somente o spy consegue manipular essas propriedades.
- Um bom local para colocar as propriedades é acima do método ou propriedade correspondente.

Exemplos

```swift
final class MyProtocolSpy: MyProtocol {

    private(set) var currentDeeplinkAccessed = false
    var currentDeeplinkToBeReturned = Deeplink()
    var currentDeeplink: Deeplink {
        currentDeeplinkAccessed = true
        return currentDeeplinkToBeReturned
    }

    private(set) var runCalled = false
    private(set) var runCount = 0
    private(set) var runDeeplinkPassed: Deeplink?
    var runToBeReturned = false

    func run(deeplink: Deeplink) -> Bool {
        runCalled = true
        runCount += 1
        runDeeplinkPassed = deeplink
        return runToBeReturned
    }
}
```
