var index = 0;

var AppInput = new Vue({
	el: '#input',
	data:
	{
        identifier: null,
	    titleMenu: "rcore",
	    float: "middle_screen",
	    position: "middle_screen",
	    ChooseText: "Accept",
	    CloseText: "Close",
	    message: "",
	    visible: false,
	},
    methods: {
        Choose: function(){
            $.post('http://MenuAPI/inputmethod', JSON.stringify({
                identifier: this.identifier,
                message: this.message,
            }));
        },
        Close: function(){
            $.post('http://MenuAPI/close', JSON.stringify({
                identifier: this.identifier,
            }));
        },
    },
});

var App = new Vue({
	el: '#menu',
	data:
	{
        identifier: null,
	    titleMenu: "rcore",
	    float: "left",
	    position: "middle",
	    visible: true,
		menu: [],
	},
});
function setActiveMenuIndex(index, active_){
    for(var i = 0; i < App.menu.length; i++){ App.menu[i].active = false }
    if(App.menu[index] != null) App.menu[index].active = active_
}

// Menu
$(function(){
    function display(bool) {
        App.visible = bool;
    }
    display(false);
	window.addEventListener('message', function(event) {
        var item = event.data;

        if(item.type === "reset"){
            App.menu = [];
        }

        if(item.type === "add"){
            App.menu.push({
                label: item.label,
                number: item.index,
                active: false,
            });
        }

        if(item.type === "title"){
            App.titleMenu = item.title
        }

        if (item.type === "ui"){
            display(item.status);
            if(item.properties){
                App.float = item.properties.float;
                App.position = item.properties.position;
            }
            App.identifier = item.identifier;
            index = 0;
            setActiveMenuIndex(0, true)
        }

	    if(App.visible && !AppInput.visible){
            if (item.type === "enter"){
                $.post('http://MenuAPI/clickItem', JSON.stringify({
                    index: App.menu[index].number,
                    identifier: App.identifier,
                }));
            }

            if (item.type === "up"){
                var lastIndex = index;
                index --;
                if(index < 0) {
                    index = App.menu.length -1
                    document.getElementById('scrolldiv').scrollTop = 90000;
                    }else{
                    document.getElementById('scrolldiv').scrollTop -= 33;
                }
                setActiveMenuIndex(index, true)

                $.post('http://MenuAPI/selectNew', JSON.stringify({
                    index: App.menu[index].number,
                    identifier: App.identifier,
                    newIndex: App.menu[index].number,
                    oldIndex: App.menu[lastIndex].number,
                }));
            }

            if (item.type === "down"){
                var lastIndex = index;
                index ++;
                if(index > App.menu.length -1) {
                    index = 0
                    document.getElementById('scrolldiv').scrollTop = 0;
                    }else{
                    document.getElementById('scrolldiv').scrollTop += 33;
                }

                setActiveMenuIndex(index, true)

                $.post('http://MenuAPI/selectNew', JSON.stringify({
                    index: App.menu[index].number,
                    identifier: App.identifier,
                    newIndex: App.menu[index].number,
                    oldIndex: App.menu[lastIndex].number,
                }));
            }
		}
	})
});

// Input
$(function(){
    function display(bool) {
        AppInput.visible = bool;
    }
    display(false);
	window.addEventListener('message', function(event) {
        var item = event.data;

        if(item.type === "title_input"){
            AppInput.titleMenu = item.title
        }

        if (item.type === "ui_input"){
            display(item.status);
            if(item.properties){
                AppInput.float = item.properties.float;
                AppInput.position = item.properties.position;
                AppInput.ChooseText = item.properties.ChooseText;
                AppInput.CloseText = item.properties.CloseText;
            }
            AppInput.identifier = item.identifier;
        }
	})
});