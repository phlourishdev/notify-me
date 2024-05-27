# notify-me

Short bash script to notify me to take the fries out of the oven. So far only tested on Fedora Linux and Gnome. It uses `aplay` and `notify-send`. If it doesn't work on your machine, feel free to open an issue or pull request.

## Usage

1. Allow execution of the script
```bash
chmod +x ./notify-me.sh
```

2. Execute it 
```bash
./notify-me.sh $TIME $TIMER_DESCRIPTION
```
The format of `$TIME` is HH:MM:SS, so `"1:30:30"`, for 1 hour, 30 minutes and 30 seconds.
`$TIMER_DESCRIPTION` can be left empty.

## Attributions

New Notification #7 by UNIVERSFIELD -- https://freesound.org/s/736267/ -- License: Attribution 4.0