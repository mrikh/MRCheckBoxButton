# MRCheckBoxButton
Check box button, add border, fill color along with tick drawing animation. Use storyboard to set properties or code whatver. 

You will need to add the ***MRCheckBoxButton.swift*** to your project and subclass the `UIButton` to this class.
To set properties using the storyboard, just open up the attributes inspector.

![alt tag](http://i.imgur.com/riyWSA5.png) 

Also you will have to do just one more thing in the attributes inspector.
Just like in the screenshot below, make sure you set the `State Config` to `Selected` and then set the `UIButton` type to `Custom`. If you don't do this then when you tap the button, you'll get a blue background :D

![alt tag](http://i.imgur.com/ojWi3pm.png) 

And in your code all you have to do is change the selected state of the subclassed `UIButton` to show or hide the tick. Sorta like this:

    @IBAction func buttonAction(_ sender: MRCheckBoxButton) {
        
        sender.isSelected = !sender.isSelected
    }

And watch the magic happen:

![alt tag](https://media.giphy.com/media/3FD60EilTL8Jy/giphy.gif)
