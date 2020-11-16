function [value]= cardValue (n,q)
% Set up variables to name the various sprites
empty_sprite = 1;
card_sprites = 21:72;

% Assigns point values to cards
deck_values = [11 2:10 10 10 10 11 2:10 10 10 10 11 2:10 10 10 10 11 2:10 10 10 10];

% Shuffles the deck 
shuffled_deck = randperm(52); % Random permutation of numbers 1 to 52
card_display(n) = card_sprites(shuffled_deck(q));
card_valuei(n) = card_display(n) - 20;
card_value(n) = deck_values(card_valuei(n))
value = card_value(n)

