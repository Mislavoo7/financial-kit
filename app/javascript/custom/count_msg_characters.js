window.countMsgCharacters = function (className, msgId) {
  var msg = document.getElementById(msgId);
  var id = document.querySelector(`.${className}`);

  msg.textContent = `${id.value ? id.value.length : 0} / ${id.getAttribute('maxlength')}`;
};
