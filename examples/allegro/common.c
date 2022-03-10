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
#include <stdarg.h>

void abort_example(char const *format, ...);
void open_log(void);
void open_log_monospace(void);
void close_log(bool wait_for_user);
void log_printf(char const *format, ...);

#ifdef ALLEGRO_POPUP_EXAMPLES

#include "allegro5/allegro_native_dialog.h"

ALLEGRO_TEXTLOG *textlog = NULL;

void abort_example(char const *format, ...)
{
   char str[1024];
   va_list args;
   ALLEGRO_DISPLAY *display;

   va_start(args, format);
   vsnprintf(str, sizeof str, format, args);
   va_end(args);

   if (al_init_native_dialog_addon()) {
      display = al_is_system_installed() ? al_get_current_display() : NULL;
      al_show_native_message_box(display, "Error", "Cannot run example", str, NULL, 0);
   }
   else {
      fprintf(stderr, "%s", str);
   }
   exit(1);
}

void open_log(void)
{
   if (al_init_native_dialog_addon()) {
      textlog = al_open_native_text_log("Log", 0);
   }
}

void open_log_monospace(void)
{
   if (al_init_native_dialog_addon()) {
      textlog = al_open_native_text_log("Log", ALLEGRO_TEXTLOG_MONOSPACE);
   }
}

void close_log(bool wait_for_user)
{
   if (textlog && wait_for_user) {
      ALLEGRO_EVENT_QUEUE *queue = al_create_event_queue();
      al_register_event_source(queue, al_get_native_text_log_event_source(
         textlog));
      al_wait_for_event(queue, NULL);
      al_destroy_event_queue(queue);
   }

   al_close_native_text_log(textlog);
   textlog = NULL;
}

void log_printf(char const *format, ...)
{
   char str[1024];
   va_list args;
   va_start(args, format);
   vsnprintf(str, sizeof str, format, args);
   va_end(args);
   al_append_native_text_log(textlog, "%s", str);
}

#else

void abort_example(char const *format, ...)
{
   va_list args;
   va_start(args, format);
   vfprintf(stderr, format, args);
   va_end(args);
   exit(1);
}

void open_log(void)
{
}

void open_log_monospace(void)
{
}

void close_log(bool wait_for_user)
{
   (void)wait_for_user;
}

void log_printf(char const *format, ...)
{
   va_list args;
   va_start(args, format);
   #ifdef ALLEGRO_ANDROID
   char x[1024];
   vsnprintf(x, sizeof x, format, args);
   ALLEGRO_TRACE_CHANNEL_LEVEL("log", 1)("%s", x);
   #else
   vprintf(format, args);
   #endif
   va_end(args);
}

#endif

/* vim: set sts=3 sw=3 et: */
