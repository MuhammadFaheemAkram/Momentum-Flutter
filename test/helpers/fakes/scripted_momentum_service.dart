import 'package:momentum/core/network/dto/backup_dto.dart';
import 'package:momentum/core/network/dto/demo_dto.dart';
import 'package:momentum/core/network/momentum_service.dart';

/// A [MomentumService] that answers each `fetchDemo` with the next scripted
/// reply: a [DemoDto] to return, or anything else to throw. After the
/// script, it repeats the last reply.
class ScriptedMomentumService implements MomentumService {
  ScriptedMomentumService(List<Object> replies) : _replies = [...replies];

  final List<Object> _replies;
  var calls = 0;

  /// From now on, answer with [demo].
  void succeedWith(DemoDto demo) => _replies
    ..clear()
    ..add(demo);

  @override
  Future<DemoDto> fetchDemo() async {
    final reply = _replies[calls.clamp(0, _replies.length - 1)];
    calls++;
    if (reply is DemoDto) return reply;
    throw reply;
  }

  @override
  Future<BackupReceiptDto> uploadBackup(BackupDto backup) =>
      throw UnimplementedError('only the demo is scripted');
}
