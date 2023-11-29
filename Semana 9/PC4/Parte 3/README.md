# Pregunta 3

**¿Cuál es el problema con este enfoque dado, cuando quieres probar el metodo workday?.**

```rb
class CurrentDay
    def initialize
        @date = Date.today
        @schedule = MonthlySchedule.new(@date.year,
        @date.month)
    end
    def work_hours
        @schedule.work_hours_for(@date)
    end
    def workday?
        !@schedule.holidays.include?(@date)
    end
end
```

El problema del código dado, es que estamos haciendo una llamada externa por medio de `MonthlySchedule`. Lo cual no se debería realizar, pues de haber problemas sobre este, nos dará error en las pruebas, mas no tenemos errores en nuestra lógica.