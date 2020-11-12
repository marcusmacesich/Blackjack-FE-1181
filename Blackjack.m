clear
clc

scene = simpleGameEngine('retro_cards.png',16,16,8,[255,255,255]);

emptySprite = 1;
blankCardSprite = 2;
cardSprites = 21:72;

deckValues = [11 2:9 10 10 10 11 2:9 10 10 10 11 2:9 10 10 10 11 2:9 10 10 10]
% Assigns point values to cards

for i = 1:2
dealerDraw = randi(
