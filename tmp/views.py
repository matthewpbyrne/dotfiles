import pickle

from django import forms
from django.http import HttpResponse
from django.shortcuts import render
from django.template import Context, Template
from django.views.decorators.csrf import csrf_exempt
from django.views.generic.detail import DetailView, SingleObjectMixin
from django.views.generic.edit import CreateView, FormView, ModelFormMixin, UpdateView
from django.views.generic.list import ListView

from .models import Tray


class MultiWidgetBasic(forms.widgets.MultiWidget):
    def __init__(self, attrs=None):
        widgets = [forms.TextInput(), forms.TextInput()]
        super(MultiWidgetBasic, self).__init__(widgets, attrs)

    def decompress(self, value):
        if value:
            return pickle.loads(value)
        else:
            return ["", ""]


class MultiExampleField(forms.fields.MultiValueField):
    widget = MultiWidgetBasic

    def __init__(self, *args, **kwargs):
        list_fields = [
            forms.fields.CharField(max_length=31),
            forms.fields.CharField(max_length=31),
        ]
        super(MultiExampleField, self).__init__(list_fields, *args, **kwargs)

    def compress(self, values):
        ## compress list to single object
        ## eg. date() >> u'31/12/2012'
        return pickle.dumps(values)


class EditMixin:
    model = Tray
    fields = [
        "best_before",
        "purchased_on",
        "quantity",
    ]


# ModelFormMixin


class TrayForm(forms.ModelForm):
    # best_before = forms.DateField()
    best_before = MultiExampleField()
    purchased_on = forms.DateField()
    quantity = forms.CharField()

    class Meta:
        model = Tray
        fields = [
            "best_before",
            "purchased_on",
            "quantity",
        ]


class TrayUpdateView2(FormView):
    template_name = "eggs/tray_form.html"
    form_class = TrayForm
    # success_url = '/thanks/'

    def form_valid(self, form):
        # This method is called when valid form data has been POSTed.
        # It should return an HttpResponse.
        # form.send_email()
        return super().form_valid(form)

    def get_success_url(self):
        return self.form.get_absolute_url()


class TrayCreate(EditMixin, CreateView):
    pass


class TrayDetailView(DetailView):
    model = Tray


class TrayListView(ListView):
    model = Tray
    paginate_by = 100  # if pagination is desired


# class TrayUpdateView(EditMixin, UpdateView):
# pass


class TrayUpdateView(UpdateView):
    form_class = TrayForm
    model = Tray

    # model = Tray
    # fields = [
    # "best_before",
    # "purchased_on",
    # "quantity",
    # ]


class FormForm(forms.Form):
    a = forms.BooleanField()
    b = forms.CharField(max_length=32)
    c = forms.CharField(max_length=32, widget=forms.widgets.Textarea())
    d = forms.CharField(max_length=32, widget=forms.widgets.SplitDateTimeWidget())
    e = forms.CharField(max_length=32, widget=MultiWidgetBasic())
    f = MultiExampleField()


@csrf_exempt
def page(request):
    form = FormForm()
    if request.method == "POST":
        form = FormForm(request.POST)

    t = Template("""<form method="post" action=".">{{f}}<input type="submit"><form>""")
    c = {"f": form.as_p()}
    return HttpResponse(t.render(Context(c)))
