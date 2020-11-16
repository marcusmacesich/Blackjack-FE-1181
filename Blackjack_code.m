clc
clear

% Initialize scene
my_scene = simpleGameEngine('retro_cards.png',16,16,8,[255,255,255]);

% Set up variables to name the various sprites
empty_sprite = 1;
card_sprites = 21:72;

card = cardValue(1,1)

%Runs the game until breaks player breaks 21 or stands
player_hand = 7;
game_runs = 1;
dealer_hand = 10;
while game_runs == 1
    player_decision = input('Enter 2 if you want to stand or enter 1 if you want to hit: ')
    if player_decision == 1
        player_hand = player_hand + card
        if player_hand > 21 
            game_runs = 0;
        end
    elseif player_decision == 2
        game_runs = 0;
    else
       fprintf('Invalid entry \n')
    end
end

% Checks who won game
if player_hand > dealer_hand && player_hand <= 21
        fprintf('Winner! \n')
        game_runs = 0;
elseif player_hand < dealer_hand || player_hand > 21
        fprintf('Loser! \n')
        game_runs = 0;
elseif player_hand == dealer_hand
        fprintf('Tie! \n')
        game_runs = 0;
end