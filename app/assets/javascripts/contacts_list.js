$(document).ready(function() {
  var $contacts = $('.contact');
  bindDeleteHandlers();
  bindAllHandler($contacts);
  bindInternationalFilterHandler($contacts);
  bindExtensionFilterHandler($contacts);
  bindDotComEmailFilterHandler($contacts);
  bindEmailSortHandler();
});

function bindDeleteHandlers() {
  $('.delete-button').on('click', function(event) {
    event.preventDefault();
    var contact = $(this).closest('tr');
    deleteContact(contact);
  })
}

function bindAllHandler($contacts){
  $('#all').on('click', function(event) {
    event.preventDefault();
    deactivateButtons();
    unFilterAll($contacts);
    $(this).toggleClass('active');
  })
}

function bindInternationalFilterHandler($contacts) {
  $('#international-filter-button').on('click', function(event) {
    event.preventDefault();
    deactivateButtons();
    filterInternationalContacts($contacts);
    $(this).toggleClass('active');
  })
}

function bindExtensionFilterHandler($contacts) {
  $('#extension-filter-button').on('click', function(event) {
    event.preventDefault();
    deactivateButtons();
    filterExtensions($contacts);
    $(this).toggleClass('active');
  })
}

function bindDotComEmailFilterHandler($contacts) {
  $('#dot-com-filter-button').on('click', function(event) {
    event.preventDefault();
    deactivateButtons();
    filterDotComEmails($contacts);
    $(this).toggleClass('active');
  })
}

function bindEmailSortHandler() {
  $('#sort-by-email-address').on('click', function(event) {
    event.preventDefault();
    sortByEmail();
    deactivateButtons();
    $(this).toggleClass('active');
  })
}

function deactivateButtons() {
  $('button').removeClass('active');
}

function deleteContact(contact) {
  var contactId = contact.data().id;
  $.ajax({
    url: '/contacts/' + contactId,
    type: 'DELETE',
    data: { id: contactId },
    complete: function() {
      contact.remove();
    }
  })
}

function unFilterAll($contacts) {
  $contacts.each(function(_index, contact) {
    $(contact).show();
  })
}

function filterInternationalContacts($contacts) {
  unFilterAll($contacts);
  var $domesticContacts = $contacts.filter(function(_index, contact) {
    return !$(contact).data().international;
  });
  $domesticContacts.each(function(_index, contact) {
    $(contact).toggle();
  });
}

function filterExtensions($contacts) {
  unFilterAll($contacts);
  var $nonExtensions = $contacts.filter(function(_index, contact) {
    return $(contact).data().extension === "";
  });
  $nonExtensions.each(function(_index, contact) {
    $(contact).toggle();
  });
}

function filterDotComEmails($contacts) {
  unFilterAll($contacts);
  var $nonDotComs = $contacts.filter(function(_index, contact) {
    return !$(contact).data().email.includes('.com');
  });
  $nonDotComs.each(function(_index, contact) {
    $(contact).toggle();
  });
}

function sortByEmail() {
  var arr = [];
  
  $('.contact').each(function() {
    var email = $(this).data().email;
    arr.push([email, $(this)]);
    $(this).remove()
  });
  
  var sortedContacts = arr.sort();
  
  sortedContacts.forEach(function(element) {
    $('#contacts').append(element[1]);
  });
  
  $(this).toggleClass('active')
}
