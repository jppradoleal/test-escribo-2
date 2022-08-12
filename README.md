![Gameplay do jogo](./assets/images/gameplay.gif)

![3 velas seguindo um cookie com boca](./assets/images/splash.png) 
# Cookie-man against Candle boys. 🍪🕯
## Teste 2 - Escribo 

O objetivo deste teste é implementar um jogo de labirinto no flutter. Você deverá replicar a jogabilidade desta versão: https://www.google.com/logos/2010/pacman10-i.html

O jogo deve ser desenvolvido em Flutter utilizando o pacote Bonfire (https://pub.dev/packages/bonfire). O mapa deve ser criado utilizando o Tiled (https://www.mapeditor.org/).

## Requisitos. 📃

- Você pode utilizar imagens que achar na web.
- Replique todas as características do jogo (comidas que incrementam a pontuação, NPCs que circulam pelo labirinto, colisões com o NPC que tiram vidas do jogador, itens de poder que permitem comer os NPCs, etc).
- Use todos os efeitos e animações que conhece para deixar o jogo mais interativo possível.
- Sua implementação deve estar em um repositório público no Github.
- Escreva um README no seu repositório com as instruções de como rodar o seu projeto e como podemos testá-lo.

## Considerações finais. 👨‍🏫

Me baseei bastante nas documentações do [Flame](https://docs.flame-engine.org/1.2.0) e do [Bonfire](https://bonfire-engine.github.io/) já que não havia utilizado a ferramenta antes. O jogo tem alguns bugs que foram reconhecidos mas que relevei para cumprir com o prazo, são eles:

* Algumas vezes o player trava na parede ao usar os teleportes.
* Os inimigos não tentam se aproximar mais quando o player está parado.
* Ao passar por cima das moedas, nem sempre elas são coletadas.
* Algumas vezes o player trava nas paredes.
* Algumas vezes a música não volta a tocar quando é clicado reset ou jogar novamente.
* A música continua tocando quando o jogo está em background.
* Na versão web a música não funciona.
* Na versão web o efeito de neon(transparência no spritesheet) não funciona.

Pelo tempo gasto no aprendizado da lib, também não consegui implementar a parte de testes unitários.

## Instruções. 🛠

1. Clone o repositório localmente `git clone git@github.com:jppradoleal/test-escribo-2.git`.
2. Acesse a pasta `cd test-escribo-2`.
3. Baixe os pacotes `flutter pub get`.
4. Se tiver o Android Studio instalado, basta iniciar o emulador. Caso contrário conecte um celular no *modo depuração por USB* ao ADB.
5. Execute o app `flutter run`.

## Instruções de jogo.

* O controle esquerdo movimenta o cookie.
* O botão superior direito reseta a fase.
* O objetivo é coletar todas as moedas.
* Ao obter a **gema laranja**, por 5 segundos os inimigos deixam de seguir e passam a correr aleatóriamente, tocá-los faz com que eles voltem ao centro da fase.
* Os buracos nas laterais permitem sair pelo lado inverso, como teleportes.
* Os açucares contam como 10 moedas e aumentam a velocidade por 1s.