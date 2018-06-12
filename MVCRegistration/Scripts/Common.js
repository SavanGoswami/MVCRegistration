//Show Message for Success, Danger and Warning
function ShowMessage(type, message) {

    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": true,
        "progressBar": true,
        "positionClass": "toast-top-center",
        "width": "1000",
        "preventDuplicates": false,
        "showDuration": "300",
        "hideDuration": "100",
        "timeOut": "7000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }

    if (type == null || type == 'undefined') {
        type = 'success';
    }

    if (message != null && message != 'undefined' || message != '') {
        if (type == 'danger') {
            toastr.error(message);
        }
        else if (type == 'success') {
            toastr.success(message);
        }
        else if (type == 'warning') {
            toastr.warning(message);
        }
        else {
            toastr.info(message);
        }
    }

}