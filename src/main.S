.syntax unified
.global main

.type main, %function
main:
  nop
  bl init
  mov r4, 0x0000            // Starting level 
  mov r5, 10                // lower bound for -ve half 
  neg r5, r5
  mov r6, 10                // upper bound for +ve half
  mov r8, 0                 // current level pointer

  loop:

    first_half:
      mov r7, 0             // counter for staying at same level

      increment1:
        level1:
          mov r0, r8          // copy value of current sample point
          bl BSP_AUDIO_OUT_Play_Sample    // play sample
          add r7, r7, 1       // increment counter
          cmp r7, 10          // compair counter 
          bne level1           // branch if the counter has not reached desired value yet

        mov r7, 0             // reset counter
        add r8, r8, 1         // increment level
        cmp r8, r6            // check if level value has reached upper bound for upper half
      bne increment1           // if upper bound not reached yet repeat the process 

      decrement1:
        level2:
          mov r0, r8           // copy value of current sample point 
          bl BSP_AUDIO_OUT_Play_Sample    // play sound sample
          add r7, r7, 1        // increment counter
          cmp r7, 10           // compair counter for desired value
        bne level2             // branch if the counter has not reached desired value yet

        mov r7, 0             // reset counter
        sub r8, r8, 1         // decrement level
        cmp r8, 0             // check if level value has reached lower bound for upper half
      bne decrement1           // if upper bound not reached yet repeat the process

    next_half:
      mov r7, 0             // counter for staying at same level

      increment2:
        level3:
          mov r0, r8          // copy value of current sample point
          bl BSP_AUDIO_OUT_Play_Sample    // play sample
          add r7, r7, 1       // increment counter
          cmp r7, 10          // compair counter 
          bne level3           // branch if the counter has not reached desired value yet

        mov r7, 0             // reset counter
        sub r8, r8, 1         // decrement level
        cmp r8, r5            // check if level value has reached lower bound for lower half
      bne increment2          // if lower bound not reached yet repeat the process 

      decrement2:
        level4:
          mov r0, r8           // copy value of current sample point 
          bl BSP_AUDIO_OUT_Play_Sample    // play sound sample
          add r7, r7, 1        // increment counter
          cmp r7, 10           // compair counter for desired value
        bne level4             // branch if the counter has not reached desired value yet

        mov r7, 0             // reset counter
        add r8, r8, 1         // increment level
        cmp r8, 0             // check if level value has reached upper bound for lower half
      bne decrement2          // if upper bound not reached yet repeat the process

  b loop
.size main, .-main