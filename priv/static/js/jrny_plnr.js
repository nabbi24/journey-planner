
function protectPasswd(){
  $('input[type=password]').on('copy paste drag select', function(e) {
    e.preventDefault();
    return false; 
  });
}

function showInfo(msg) {
  $("#msg_board").attr('class', 'info').text("[info] " + msg).show(0).fadeOut(5000);
}
function showWarn(msg) {
  $("#msg_board").attr('class', 'warn').text("[warn] " + msg).show(0).fadeOut(10000);
}
function showError(msg) {
  $("#msg_board").attr('class', 'error').text("[error] " + msg).show(0);
}

// ========================================================
// Utility ================================================
// ========================================================
function encryptPasswd(passwd) {
  //TODO encrypt as server decrypt
  return passwd.split('').reverse().join('');
}

