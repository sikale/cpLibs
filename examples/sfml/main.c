/*=============================================================================
   ___ ___
  / __| _ \__ _ ___™
 | (__|  _/ _` (_-<
  \___|_| \__,_/__/
    C for Delphi

 Copyright © 2020-22 tinyBigGAMES™ LLC
 All rights reserved.

 Website: https://tinybiggames.com
 Email  : support@tinybiggames.com

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. The origin of this software must not be misrepresented; you must not
    claim that you wrote the original software. If you use this software in
    a product, an acknowledgment in the product documentation would be
    appreciated but is not required.
 2. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.

 3. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in
    the documentation and/or other materials provided with the
    distribution.

 4. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived
    from this software without specific prior written permission.

 5. All video, audio, graphics and other content accessed through the
    software in this distro is the property of the applicable content owner
    and may be protected by applicable copyright law. This License gives
    Customer no rights to such content, and Company disclaims any liability
    for misuse of content.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
=============================================================================*/

#include <stdio.h>
#include <SFML/Audio.h>
#include <SFML/Graphics.h>

int main(void)
{
  sfVideoMode mode = {800, 600, 32};
  sfRenderWindow* window;
  sfTexture* texture;
  sfSprite* sprite;
  sfFont* font;
  sfText* text;
  sfMusic* music;
  sfEvent event;

  // Create the main window
  window = sfRenderWindow_create(mode, "SFML window", sfResize | sfClose, NULL);
  if (!window)
      return 1;

  // Load a sprite to display
  texture = sfTexture_createFromFile("data/cpas-logo.png", NULL);
  if (!texture)
      return 1;
  sprite = sfSprite_create();
  sfSprite_setTexture(sprite, texture, sfTrue);

  // Create a graphical text to display
  font = sfFont_createFromFile("data/default.ttf");
  if (!font)
      return 1;
  text = sfText_create();
  sfText_setString(text, "Hello SFML");
  sfText_setFont(text, font);
  sfText_setCharacterSize(text, 50);

  // Load a music to play
  music = sfMusic_createFromFile("data/song02.ogg");
  if (!music)
      return 1;

  // Play the music
  sfMusic_play(music);
  sfMusic_setLoop(music, sfTrue);
  
  // Start the game loop
  while (sfRenderWindow_isOpen(window))
  {
      // Process events
      while (sfRenderWindow_pollEvent(window, &event))
      {
          // Close window : exit
          if (event.type == sfEvtClosed)
              sfRenderWindow_close(window);
      }

      // Clear the screen
      sfRenderWindow_clear(window, sfBlack);

      // Draw the sprite
      sfRenderWindow_drawSprite(window, sprite, NULL);

      // Draw the text
      sfRenderWindow_drawText(window, text, NULL);

      // Update the window
      sfRenderWindow_display(window);
  }

  // Cleanup resources
  sfMusic_destroy(music);
  sfText_destroy(text);
  sfFont_destroy(font);
  sfSprite_destroy(sprite);
  sfTexture_destroy(texture);
  sfRenderWindow_destroy(window);
  
  return 0;
}