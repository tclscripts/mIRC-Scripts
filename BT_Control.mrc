/* 
    ____  __           __      ______            __    
   / __ )/ /___ ______/ /__   /_  __/___  ____  / /____
  / __  / / __ `/ ___/ //_/    / / / __ \/ __ \/ / ___/
 / /_/ / / /_/ / /__/ ,<      / / / /_/ / /_/ / (__  ) 
/________\__,_/\___/____|    /_/  \____/\____/_/____/  
  / ____/___  ____  / /__________  / /                 
 / /   / __ \/ __ \/ __/ ___/ __ \/ /                  
/ /___/ /_/ / / / / /_/ /  / /_/ / /                   
\____/\____/_/ /_/\__/_/   \____/_/                    
                                                       
Proudly presented by QueenElsa.           Version 2.0
INSTRUCTIONS: Load into a black REMOTES file. Then right click in any channel to activate.
FOR HELP: /join #development on Undernet

*/
;Initializate GUI menu hook
menu channel { 
  $iif($chan = $chan,$chan Control Center): { /dialog -m bt_control bt_control }  
}

;Main dialog code
dialog bt_control {
  title "BT Controls"
  size -1 -1 232 142
  option dbu
  icon C:\Windows\System32\shell32.dll, 21
  tab "Ban", 11, 95 3 134 109
  button "Ban", 19, 98 19 42 12, tab 11 flat
  button "Blacklist", 20, 98 32 42 12, tab 11 flat
  button "Sticky Ban", 21, 98 45 42 12, tab 11 flat
  button "Drone Ban", 22, 98 58 42 12, tab 11 flat
  button "Bad Nick Ban", 24, 98 84 42 12, tab 11 flat
  button "Bad Ident Ban", 25, 98 97 42 12, tab 11 flat
  button "Spam Ban", 26, 141 19 42 12, tab 11 flat
  button "Bad Word Ban", 27, 141 32 42 12, tab 11 flat
  button "Virus Ban", 28, 141 45 42 12, tab 11 flat
  button "Mibbit Ban", 29, 141 58 42 12, tab 11 flat
  button "Gag", 30, 141 71 42 12, tab 11 flat
  button "Ungag", 31, 141 84 42 12, tab 11 flat
  button "Unban", 32, 141 97 42 12, tab 11 flat
  button "Troll Ban", 33, 184 19 42 12, tab 11 flat
  button "Search Bans...", 34, 184 32 42 12, tab 11 flat
  button "View Banlist...", 35, 184 45 42 12, tab 11 flat
  button "Kick", 36, 184 58 42 12, tab 11 flat
  button "Warn", 37, 184 71 42 12, tab 11 flat
  button "Bot Ban", 23, 98 71 42 12, tab 11 flat
  tab "Cmds", 17
  button "Op/Deop", 16, 98 19 42 12, tab 17 flat
  button "Voice/Devoice", 40, 98 32 42 12, tab 17 flat
  button "Halfop/Dehalfop", 41, 98 45 42 12, tab 17 flat
  button "Man...", 42, 98 58 42 12, tab 17 flat
  button "Version", 43, 98 71 42 12, tab 17 flat
  button "Mode", 44, 98 84 42 12, tab 17 flat
  button "Cycle", 45, 98 97 42 12, tab 17 flat
  button "Say", 46, 141 19 42 12, tab 17 flat
  button "Act", 47, 141 32 42 12, tab 17 flat
  button "Broadcast", 48, 141 45 42 12, tab 17 flat
  button "Invite", 49, 141 58 42 12, tab 17 flat
  button "Activity", 50, 141 71 42 12, tab 17 flat
  button "Topic", 51, 141 84 42 12, tab 17 flat
  button "My Setting", 52, 141 97 42 12, tab 17 flat
  button "Help", 53, 184 19 42 12, tab 17 flat
  button "Rehash", 54, 184 32 42 12, tab 17 flat
  button "Privmsg", 55, 184 45 42 12, tab 17 flat
  button "Op Privmsg", 56, 184 58 42 12, disable tab 17 flat
  tab "Setup", 3
  button "Set Bot Nick", 4, 98 19 42 12, tab 3 flat
  edit "", 5, 141 20 84 10, tab 3
  button "Use Bot", 6, 98 32 42 12, disable tab 3 flat
  combo 7, 141 33 84 30, disable tab 3 size drop
  button "Remove All Bots", 8, 98 45 42 12, disable tab 3 flat
  box "Directives", 10, 98 58 127 52, tab 3
  button "Save Directives", 203, 179 95 43 12, tab 3 flat
  check "Remember Target User between commands", 200, 99 65 125 10, tab 3 flat
  text "Target Channel:", 12, 2 3 43 8
  link "%channel%", 13, 46 3 45 8
  text "Target User (below):", 14, 2 13 89 8
  combo 15, 2 25 91 88, sort size edit vsbar
  text "Parameters:", 57, 2 131 35 8
  edit "", 58, 37 130 192 10
  text "Fast Duration:", 60, 2 118 35 8
  radio "15 Mins", 1000, 38 116 28 12, group flat
  radio "1 Hour", 1001, 68 116 27 12, flat
  radio "1 Day", 1002, 97 116 26 12, flat
  radio "2 Weeks", 1003, 125 116 31 12, flat
  radio "3 Months", 1004, 158 116 33 12, flat
  radio "Permanent", 1005, 193 116 36 12, flat
  check "Remember Parameters between commands", 201, 99 74 125 10, tab 3 flat
  check "Remember Fast Duration between commands", 202, 99 83 125 10, tab 3 flat
  menu "&File", 1
  ;item "&Report a bug", 9, 1 
  item "E&xit BT Controls", 2, 1, ok
}

;Initialize dialog
on *:dialog:bt_control:init:*:{
  ;Get all nicks in chan 
  /writeini bt.ini operation activechan $active
  var %total = $nick($active,0) , %x = 1
  while ( %x <= %total ) {
    /did -i $dname 15 %x $nick($active,%x)
  inc %x }
  ;Get bot nick
  /did -o $dname 5 0 $readini(bt.ini, n, settings, botnick)
  ;Set identifiers
  /did -o $dname 13 0 $chan
  ;Restore directives setting
  if ($readini(bt.ini, n, settings, r-TU) == no) { /did -u $dname 200 0 }
  if ($readini(bt.ini, n, settings, r-TU) == yes) { /did -c $dname 200 0 }
  if ($readini(bt.ini, n, settings, r-PR) == no) { /did -u $dname 201 0 }
  if ($readini(bt.ini, n, settings, r-PR) == yes) { /did -c $dname 201 0 }
  if ($readini(bt.ini, n, settings, r-FD) == no) { /did -u $dname 202 0 } 
  if ($readini(bt.ini, n, settings, r-FD) == yes) { /did -c $dname 202 0 } 
}

;Clear User Input - Main Block
alias  cui { 
  ;Dont remember target user
  if ($readini(bt.ini, n, settings, r-TU) == no) { 
    /did -d $dname 15 0
    ;/echo -a BT_Control DEBUG: Target User - Cleared
    halt
  } 
  ;Remember target user
  if ($readini(bt.ini, n, settings, r-TU) == yes) {
    ;/echo -a BT_Control DEBUG: Target User - Retained  
  } 
  ;Don't remember parameters
  if ($readini(bt.ini, n, settings, r-PR) == no) { 
    ;/echo -a BT_Control DEBUG: Parameters - Cleared
    /did -r $dname 58 
  }
  ;Remember parameters
  if ($readini(bt.ini, n, settings, r-PR) == yes) { 
    ;/echo -a BT_Control DEBUG: Parameters - Retained 
  }
  if ($readini(bt.ini, n, settings, r-FD) == no) { 
    ;/echo -a BT_Control DEBUG: Fast Duration - Cleared
    /did -u $dname 1000
    /did -u $dname 1001
    /did -u $dname 1002
    /did -u $dname 1003
    /did -u $dname 1004
    /did -u $dname 1005
  }
  if ($readini(bt.ini, n, settings, r-FD) == yes) { 
    ;/echo -a BT_Control DEBUG: Fast Duration - Retained
  } 
}

;Handler for all clicked items.
on *:DIALOG:bt_control:sclick:*:{
  ;Bug report
  ;TODO: Finish bugreporting system
  /*
    if ($did == 9) { 
    /var %bugreport $$?="What bug did you encounter?"
    /join #development 
    /timer 1 5 /msg #development Hi there, I'm $nick and I found a bug within the BT_Control script. Here is my bug report: %bugreport 
    /timer 1 7 /part #development Bug report filed
  } 
  */
  ;Setup bot nick
  ;TODO: Change to add new botnick instead of using a particular nick.
  if ($did == 4) {
    if ($did(5).text == $null) { /echo -a [BT Control\Setup] You must enter the nick used by your bot. This script will not function until you've entered your bot's nick. | halt }
    else {  
      /writeini bt.ini settings botnick $did(5).text
      /echo -a [BT Control] Set bot nick to: $did(5).text 
      /echo -a [BT Control] Remember, if your bot isn't running BlackTools - this script won't be of any use to you! You can find the latest version of BlackTools at http://tclscripts.net
    }
  }
  ;Setup memory - fragment: Target User
  if ($did == 203) { 
    if ($did(200).state == 0) { /writeini bt.ini settings r-TU no | echo -a [BT Control\Setup] Okay, I won't remember the target user between each command. } 
    elseif ($did(200).state == 1) { /writeini bt.ini settings r-TU yes | echo -a [BT Control\Setup] Okay, I will remember the target user between each command. } 
    ;Setup memory - fragment: Parameters
    if ($did(201).state == 0) { /writeini bt.ini settings r-PR no | echo -a [BT Control\Setup] Okay, I won't remember the parameters between each command. }
    elseif ($did(201).state == 1) { /writeini bt.ini settings r-PR yes | echo -a [BT Control\Setup] Okay, I will remember the parameters between each command. }
    ;Setup memory - fragment: Fast Duration 
    if ($did(202).state == 0) { /writeini bt.ini settings r-FD no | echo -a [BT Control\Setup] Okay, I won't remember the fast duration between each command. }
    elseif ($did(202).state == 1) { /writeini bt.ini settings r-FD yes | echo -a [BT Control\Setup] Okay, I will remember the fast duration between each command. }
  }

  /*
  ; Bans Tab
  */
  ;Ban
  if ($did == 19) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\BAN] You must select a target user. | halt } 
    else {
      if ($did(1000).state == 1) { /msg $did(5).text b $did(13).text $did(15).seltext 15m $did(58).text | /cui | halt } 
      elseif ($did(1001).state == 1) { /msg $did(5).text b $did(13).text $did(15).seltext 1h $did(58).text | /cui | halt } 
      elseif ($did(1002).state == 1) { /msg $did(5).text b $did(13).text $did(15).seltext 1d $did(58).text | /cui | halt } 
      elseif ($did(1003).state == 1) { /msg $did(5).text b $did(13).text $did(15).seltext 14d $did(58).text | /cui | halt } 
      elseif ($did(1004).state == 1) { /msg $did(5).text b $did(13).text $did(15).seltext 90d $did(58).text | /cui | halt } 
      elseif ($did(1005).state == 1) { /msg $did(5).text b $did(13).text $did(15).seltext 0 $did(58).text | /cui | halt } 
      else {  /msg $did(5).text b $did(13).text $did(15).seltext $did(58).text | /cui | halt }
    }
  }
  ;Blacklist
  if ($did == 20) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\BLACKLIST USER] You must select a target user. | halt } 
    else {
      /msg $did(5).text black $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Sticky
  if ($did == 21) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\STICKY BAN] You must select a target user. | halt } 
    else {
      if ($did(1000).state == 1) { /msg $did(5).text stick $did(13).text $did(15).seltext 15m $did(58).text | /cui | halt } 
      elseif ($did(1001).state == 1) { /msg $did(5).text stick $did(13).text $did(15).seltext 1h $did(58).text | /cui | halt } 
      elseif ($did(1002).state == 1) { /msg $did(5).text stick $did(13).text $did(15).seltext 1d $did(58).text | /cui | halt } 
      elseif ($did(1003).state == 1) { /msg $did(5).text stick $did(13).text $did(15).seltext 14d $did(58).text | /cui | halt } 
      elseif ($did(1004).state == 1) { /msg $did(5).text stick $did(13).text $did(15).seltext 90d $did(58).text | /cui | halt } 
      elseif ($did(1005).state == 1) { /msg $did(5).text stick $did(13).text $did(15).seltext 0 $did(58).text | /cui | halt } 
      else {  /msg $did(5).text stick $did(13).text $did(15).seltext $did(58).text | /cui | halt }
    }
  }
  ;Drone
  if ($did == 22) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\DRONE BAN] You must select a target user. | halt } 
    else {
      /msg $did(5).text dr $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Bot
  if ($did == 23) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\BOT BAN] You must select a target user. | halt } 
    else {
      /msg $did(5).text bot $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Nick
  if ($did == 24) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\NICK BAN] You must select a target user. | halt } 
    else {
      /msg $did(5).text n $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Ident
  if ($did == 25) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\IDENT BAN] You must select a target user. | halt } 
    else {
      /msg $did(5).text id $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Spam
  if ($did == 26) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\SPAM BAN] You must select a target user. | halt } 
    else {
      /msg $did(5).text spam $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Bad Word
  if ($did == 27) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\BAD WORD BAN] You must select a target user. | halt } 
    else {
      /msg $did(5).text bw $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Virus
  if ($did == 28) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\VIRUS INFECTED USER BAN] You must select a target user. | halt } 
    else {
      /msg $did(5).text vr $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Mibbit
  if ($did == 29) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\MIBBIT BAN] You must select a target user. | halt } 
    else {
      /msg $did(5).text mb $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Gag
  if ($did == 30) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\GAG] You must select a target user. | halt } 
    else {
      if ($did(1000).state == 1) { /msg $did(5).text gag $did(13).text $did(15).seltext 15m $did(58).text | /cui | halt } 
      elseif ($did(1001).state == 1) { /msg $did(5).text gag $did(13).text $did(15).seltext 1h $did(58).text | /cui | halt } 
      elseif ($did(1002).state == 1) { /msg $did(5).text gag $did(13).text $did(15).seltext 1d $did(58).text | /cui | halt } 
      elseif ($did(1003).state == 1) { /msg $did(5).text gag $did(13).text $did(15).seltext 14d $did(58).text | /cui | halt } 
      elseif ($did(1004).state == 1) { /msg $did(5).text gag $did(13).text $did(15).seltext 90d $did(58).text | /cui | halt } 
      elseif ($did(1005).state == 1) { /msg $did(5).text gag $did(13).text $did(15).seltext 0 $did(58).text | /cui | halt } 
      else {  /msg $did(5).text gag $did(13).text $did(15).seltext $did(58).text | /cui | halt }
    }
  }
  ;Ungag 
  if ($did == 31) { 
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\UNGAG] You must select a target user. | halt } 
    else { 
      /msg $did(5).text ungag $did(13).text $did(15).seltext 
      /cui 
      halt 
    }
  }
  ;Unban 
  if ($did == 32) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\UNBAN] You must enter the hostmask you wish to unban. | halt } 
    else { 
      /msg $did(5).text ub $did(13).text $did(58).text 
      /cui 
      halt 
    }
  }
  ;Troll
  if ($did == 33) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\TROLL BAN] You must select a target user. | halt } 
    else {
      /msg $did(5).text troll $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Search Bans
  if ($did == 34) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\SEARCH BAN] You must enter the hostmask you wish to search the database for. | halt } 
    else {
      /msg $did(5).text sb $did(13).text $did(58).text 
      /cui
    }
  }
  ;Banlist
  if ($did == 35) {
    /msg $did(5).text banlist $did(13).text 
  }
  ;Kick
  if ($did == 36) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\KICK] You must select a target user. | halt } 
    else {
      /msg $did(5).text k $did(13).text $did(15).seltext $did(58).text 
      /cui
    }
  }
  ;Warn
  if ($did == 37) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\WARN] You must select a target user. | halt } 
    else {
      /msg $did(5).text w $did(13).text $did(15).seltext 
      /cui
    }
  }
  /*
  ; Commands Tab 
  */
  ;Op/Deop Target User
  if ($did == 16) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\OP or DEOP] You must select a target user. | halt } 
    else {
      /msg $did(5).text o $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Voice/Devoice Target User
  if ($did == 40) {
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\VOICE or DEVOICE] You must select a target user. | halt } 
    else {
      /msg $did(5).text v $did(13).text $did(15).seltext 
      /cui
    }
  }
  ;Halfop/Dehalfop Target User
  if ($did == 41) { 
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\HALFOP or DEHALFOP] You must select a target user. | halt } 
    else {  
      /msg $did(5).text ho $did(13).text $did(15).seltext
      /cui
    }
  }
  ;Bot Manual 
  if ($did == 42) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\MAN] You must enter a command. | halt } 
    else { 
      /msg $did(5).text man $did(58).text
      /cui
    }
  }
  ;Version 
  if ($did == 43) { 
    /msg $did(5).text version
  }
  ;Mode 
  if ($did == 44) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\MODE] You must enter a mode. | halt } 
    else {  
      /msg $did(5).text mode $did(13).text $did(58).text
      /cui
    }
  }
  ;Cycle 
  if ($did == 45) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\CYCLE] You must enter a part message. | halt } 
    else {  
      /msg $did(5).text cycle $did(13).text $did(58).text
      /cui
    }
  }
  ;Say
  if ($did == 46) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\SAY] You must enter a message to say in the channel. | halt } 
    else {  
      /msg $did(5).text SAY $did(13).text $did(58).text
      /cui
    }
  }
  ;Act
  if ($did == 47) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\ACT] You must enter an action to perform in the channel. | halt } 
    else {  
      /msg $did(5).text ACT $did(13).text $did(58).text
      /cui
    }
  }
  ;Broadcast
  if ($did == 48) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\BROADCAST] You must enter a message to broadcast to all channels. | halt } 
    else {  
      /msg $did(5).text broadcast $did(58).text
      /cui
    }
  }
  ;Invite
  if ($did == 49) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\INVITE] You must enter the nick of a user to invite. | halt } 
    else {  
      /msg $did(5).text i $did(13).text $did(58).text
      /cui
    }
  }
  ;Activity
  if ($did == 50) { 
    if ($did(15).text == $null) { /echo -a $asctime 4[BT Control\ACTIVITY] You must select a user to view the activity of. | halt } 
    else {  
      /msg $did(5).text activ $did(13).text $did(15).seltext
      /cui
    }
  }
  ;Topic
  if ($did == 51) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\TOPIC] You must enter a new topic. | halt } 
    else {  
      /msg $did(5).text t $did(13).text $did(58).text
      /cui
    }
  }
  ;My Settings Configuration
  if ($did == 52) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\MY SETTINGS] You must enter a setting to configure. | halt } 
    else {  
      /msg $did(5).text myset $did(13).text $did(58).text
      /cui
    }
  }
  ;Help
  if ($did == 53) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\HELP] You must enter the comand group to get help with. | /msg $did(5).text h | halt } 
    else {  
      /msg $did(5).text h $did(58).text
    }
  }
  ;Rehash
  if ($did == 54) {  
    /msg $did(5).text rehash
    /echo -a [BT Control] Reloaded all bot configurations, files and scripts.
  }
  ;Privmsg
  if ($did == 55) { 
    if ($did(15).seltext == $null) { /echo -a $asctime 4[BT Control\PRIVMSG] You must select a target user. | halt } 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\PRIVMSG] You must enter a message to send to the target user. | halt } 
    else {  
      /msg $did(5).text msg $did(15).seltext $did(58).text
      /cui
    }
  }
  ;Opmsg
  if ($did == 48) { 
    if ($did(58).text == $null) { /echo -a $asctime 4[BT Control\OP MESSAGE] You must enter a message to send to the channel ops. | halt } 
    else {  
      /msg $did(5).text omsg $did(13).text $did(58).text
      /cui
    }
  }
}
