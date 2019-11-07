; WAS:
;
; SEGA Master System Music Interface - Z80 code
; By Sebastian Tomczak

; NOW:

; Sord M5 Music Interface 
; By Charlie 'SirMorris' Robson

	.org	$2000

	di						; no interrupts please, we're brutish

	ld		sp,$7fff
	ld		hl,$8000

Loop:
	ld		a,(hl)
	bit		7,a				; bit 7 signals a write
	jr		nz,Loop

	bit		6,a				; nibble is a high nibble if bit 7 set
	jr		z,LowNibble

	sla		a				; shift the nibble into high bits
	sla		a
	sla		a
	sla		a
	or		b
	out		($20),a			; send the data to the PSG 
	jr		Loop

LowNibble:
	and		$0f
	ld		b,a				; stash
	jr		Loop

	.ds		$4000-$
