
clc
clear

my_scene = simpleGameEngine('card_image.png',16,16,8,[53,101,77]);

%%variables
card_background = 2;
face_down_card = 6;
screen_height = 6;
screen_width = 8;
dealer = 1;
player = 3;
loop = 1;

global deck_index %deck index holds position of the card being drawn from deck
global deck    %holds the values for the deck
global hand
    %the hand array holds both raw card sprite data (21-72) and card value (1-11) for
    %both dealer and player the array is formated as such:
    % hand = dealerSprite         {52, 50, 43;
    %        dealerValue         1,  2,  3;
    %        playerSprite          40, 38,  49;
    %        PlayerValue        5,   6,   8}
    

while loop
    
    %reset variable when game restarts
    deck_index = 1; 
    
    card_display = ones(screen_height,screen_width); %creates empty background
        %an array the size of the screen that holds the sprite values of the cards being displayed
        %ie   card_display = {0, 0, 0, 0, 0, 0, 0;
        %                     0,47,32, 0, 0, 0, 0;
        %                     0, 0, 0, 0, 0, 0, 0;
        %                     0,71,47,60, 0, 0, 0;
        %                     0, 0, 0, 0, 0, 0, 0;

    back_display = ones(screen_height,screen_width);%creates equal empty array for card backs
        %an array the size of the screen that holds the values for the card background (see above)
   
    hand = zeros(2,screen_width);
    
    %sets dealer, player, hit, and stand buttons on board
    card_display(dealer+1,1) = 75;
    card_display(player+1,1) = 76;
    back_display(dealer+1,1) = 5;
    back_display(player+1,1) = 7;
    card_display(screen_height,4) = 77;
    card_display(screen_height,5) = 78;
    back_display(screen_height,4) = 3;
    back_display(screen_height,5) = 3;
    
    
    deck = randperm(52); % Shuffles deck with random permutation of numbers 1 to 52


   
    %deal each player two cards  
    for hand_index = 1:2
       dealCard(dealer, hand_index) 
    end
    drawScene(my_scene,back_display,card_display)
    for hand_index = 1:2
       dealCard(player, hand_index)
    end
    
    %calculate the value of each players hand
    dealer_value = sum(hand(dealer+1,:));
    player_value = sum(hand(player+1,:));

    for hand_index = 1:2
        card_display(dealer+1,hand_index+1) = face_down_card; 
    end
    for hand_index = 1:2
        card_display(player+1,hand_index+1) = hand(player,hand_index);
        back_display(player+1,hand_index+1) = card_background;
    end

    hand_index = 3;

    drawScene(my_scene,back_display,card_display)

        
    game_runs = 1;
    while game_runs == 1
          
              
        %Get user input via mouse
        row = 0;
        column = 0;
        while ~(row == 6 && ((column == 4) || (column == 5)))
            [row,column] = getMouseInput(my_scene);
            if column == 4
                player_decision = 1;
            else
                player_decision = 2;
            end
        end
                
              
        if player_decision == 1
            dealCard(player,hand_index) %deal new card
            player_value = sum(hand(player+1,:));%sum new hand values
            card_display(player+1,hand_index+1) = hand(player,hand_index);
            back_display(player+1,hand_index+1) = card_background;
            hand_index = hand_index + 1; %increase number of cards in hand
            
            drawScene(my_scene,back_display,card_display)

            if player_value > 21
                %fprintf('You broke 21!!!!!! You Donkey!!!!! \n')
                game_runs = 0;
            end
        elseif player_decision == 2
            game_runs = 0;
        end
    end

    % Checks who won game  
    if player_value >= dealer_value && player_value <= 21
           card_display(6,:) = [79,80,81,82,83,83,84,85];
    elseif player_value < dealer_value || player_value > 21
           card_display(6,:) = [79,80,1,86,87,78,84,85];    
    end
    
  
    %display dealer value
    first_number = floor(dealer_value / 10);
    second_number = mod(dealer_value, 10);
    card_display(dealer+2,screen_width-1) = first_number+11;
    card_display(dealer+2,screen_width) = second_number+11;
    back_display(dealer+2,[7:8]) = card_background;
    
    %display player value
    first_number = floor(player_value / 10);
    second_number = mod(player_value, 10);
    card_display(player+2,screen_width-1) = first_number+11;
    card_display(player+2,screen_width) = second_number+11;
    back_display(player+2,[7:8]) = card_background;
    
    %display dealers cards
    card_display(dealer+1,[2,3]) = hand(dealer,[1,2]);
    back_display(dealer+1,[2,3]) = card_background;
    back_display(6,:) = [3,3,1,1,1,1,1,1];
    
    drawScene(my_scene,back_display,card_display)

    
    
    row = 0;
    column = 0;
    while ~(row == 6 && ((column == 1) || (column == 2)))
        [row,column] = getMouseInput(my_scene);
    end
    if(row ==6 && column == 1)
        loop = 1;
    elseif(row == 6 && column == 2)
        loop = 2;
        break;
    end  
   
 
end



function dealCard(role,hand_index)
    global deck
    global deck_index
    global hand
    deck_values = [11 2:10 10 10 10 11 2:10 10 10 10 11 2:10 10 10 10 11 2:10 10 10 10];

    
    card = deck(deck_index); %draws card from deck
    hand(role,hand_index) = card + 20;
    hand(role+1,hand_index) = deck_values(card);
    deck_index = deck_index + 1;
    
end


