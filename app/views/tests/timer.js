var x = setInterval(function myTimer() {

    const h = '<%= @end[0] %>';
    const m = '<%= @end[1] %>';
    const s = '<%= @end[2] %>';
    const test = '<%= @end %>';
    var end = new Date();
    end.setHours(h, m, s);

    var now = new Date().getTime();
    var remain = end - now

    var hours = Math.floor((remain % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)).toString();
    var minutes = Math.floor((remain % (1000 * 60 * 60)) / (1000 * 60)).toString();
    var seconds = Math.floor((remain % (1000 * 60)) / 1000).toString();

    document.getElementById("time").innerHTML = `Time Remaining: ${hours.padStart(2, '0')}:${minutes.padStart(2, '0')}:${seconds.padStart(2, '0')}`;

    if (remain < 600 && remain > 545) { // 10 minutes

    } else if (remain < 300 && remain > 245) { // 5 minutes

    } else if (remain < 60 && remain > 45) { // 1 minute

    } else if (remain < 0) {
        clearInterval(x);
        document.getElementById("time").innerHTML = "TIME EXPIRED";
        // submit question answer and close test
    }
}, 1000);