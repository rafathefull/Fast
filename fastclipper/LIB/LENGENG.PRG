//  
// ------------------------------------------------------------------------
// FASTlib for Clipper, including all source code, examples and any other 
// file has been donated to Open Source community
// 
// Manu Roibal. Bilbao, May 7 2011
// 
// ------------------------------------------------------------------------
// Please, contact me at		manuroibal@gmail.com
// Follow me at Twitter			@manuroibal
// My Linkedin profile			www.linkedin.com/manuroibal
// 
// Or visit my web site Tons of IT at	www.tonsofit.com
// 



/***********
* FAST.lib language module. English.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetEnglish()

LOCAL aArray := {}

    aAdd( aArray, "STATISTICS" )
    aAdd( aArray, "Bytes to copy  : " )
    aAdd( aArray, "Bytes file     : " )
    aAdd( aArray, "Bytes copyed   : " )
    aAdd( aArray, "Files copyed   : " )
    aAdd( aArray, "Num. files     : " )
    aAdd( aArray, "Files saved    : " )
    aAdd( aArray, "Time estimated : " )
    aAdd( aArray, "Done           : " )
    aAdd( aArray, "Insert a disk in %1" )
    aAdd( aArray, "Saving " )
    aAdd( aArray, "Do you want to cancel process? (Y/N)" )
    aAdd( aArray, "Insert the disk %1" )
    aAdd( aArray, "Backup date    : " )
    aAdd( aArray, "Created by     : " )
    aAdd( aArray, "Do you want to continue? (Y/N)" )
    aAdd( aArray, "Restoring " )
    aAdd( aArray, "Skipping " )
    aAdd( aArray, "Press any key to continue" )
    aAdd( aArray, "YN" )
    aAdd( aArray, "Su  Mo  Tu  We  Th  Fr  Sa" )
    aAdd( aArray, { "F4", "Search", "F5", "Next", "F6", "New", "F7", "Save as", "F8", "Save", "F10", "Exit" } )
    aAdd( aArray, "File: " )
    aAdd( aArray, "New output name:" )
    aAdd( aArray, "New File:" )
    aAdd( aArray, "Search:" )
    aAdd( aArray, "Do you want to save %1? (Y/N)" )
    aAdd( aArray, { "January",   "February", "March",    "April", ;
                    "May",       "June",     "July",     "August", ;
                    "September", "October",  "November", "December" } )
    aAdd( aArray, "General error accessing %1. Retry? (Y/N)" )
    aAdd( aArray, "General error creating %1. Retry? (Y/N)" )
    aAdd( aArray, "General error loading %1. Retry? (Y/N)" )
    aAdd( aArray, "General error writing %1. Retry? (Y/N)" )
    aAdd( aArray, "Formulas" )
    aAdd( aArray, "Numbers" )
    aAdd( aArray, "Edit " )
    aAdd( aArray, "Sharing violation. Retry? (Y/N)" )
    aAdd( aArray, { "F6", "Calc ", "F7", "Edit ", "F8", "Calculate", "ESC", "Exit" } )
    aAdd( aArray, "Do you want to exit? (Y/N)" )
    aAdd( aArray, "Do you want to save changes? (Y/N)" )
    aAdd( aArray, "Input value:" )
    aAdd( aArray, { "F5", "Copy", "F6", "Rename", "F8", "Delete", "ESC", "Exit" } )
    aAdd( aArray, "Do you want to exit? (Y/N)" )
    aAdd( aArray, "Cancel" )
    aAdd( aArray, "Delete %1? (Y/N)" )
    aAdd( aArray, "Rename" )
    aAdd( aArray, "Copy" )
    aAdd( aArray, { "<Ù", "Accept", "ESC", "Cancel" } )
    aAdd( aArray, " to" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Move", "<Ù", "Accept", "ESC", "Cancel" } )
    aAdd( aArray, { "P", "Pause", "Num. Lines : ", Nil } )
    aAdd( aArray, "Game Over. Play another? (Y/N)" )
    aAdd( aArray, "Pause" )
    aAdd( aArray, "Do you want to cancel the game? (Y/N)" )
    aAdd( aArray, "Do you want to cancel and lose changes? (Y/N)" )
    aAdd( aArray, "Do wou want to exit and save changes? (Y/N)" )
    aAdd( aArray, .T. )

    SetLanguage( aArray )

RETURN NIL
